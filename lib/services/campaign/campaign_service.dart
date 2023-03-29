import 'package:dio/dio.dart';
import 'package:ecosense/data/models/campaign.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/data/models/category.dart';
import 'package:ecosense/data/models/dashboard.dart';
import 'package:ecosense/services/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

class CampaignService {
  static Future<DashboardModel> getDashboard() async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.get(
      '/dashboard',
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      ),
    );
    return DashboardModel.fromJson(response.data);
  }

  static Future<List<CategoryModel>> categories() async {
    Response<Map<String, dynamic>> response = await dio.get('/categories');
    if (response.data?['error'] == false) {
      List<dynamic> categoriesJson = response.data!['categories'];
      var result =
          categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
      return result;
    }
    throw ErrorDescription('went_wrong'.i18n());
  }

  static Future<List<Campaign>> campaigns({int? categoryId}) async {
    Response<Map<String, dynamic>> response = await dio.get(
      '/campaign',
      queryParameters: {
        if (categoryId != null) 'categoryId': categoryId,
      },
    );
    if (response.data?['error'] == false) {
      List<dynamic> campaignsJson = response.data!['campaigns'];
      var result =
          campaignsJson.map((json) => Campaign.fromJson(json)).toList();
      return result;
    }
    throw ErrorDescription('went_wrong'.i18n());
  }

  static Future<CampaignDetailModel> getCampaign(int id,
      {int? recordId}) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    Response<Map<String, dynamic>> response = await dio.get(
      '/detail',
      queryParameters: {
        'id': id,
        if (recordId != null) 'recordId': recordId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (response.data?['error'] == false) {
      return CampaignDetailModel.fromJson(id, response.data!);
    }
    throw ErrorDescription('went_wrong'.i18n());
  }

  static Future<bool> joinCampaign(int campaignId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    try {
      final response = await dio.post(
        '/joincampaign',
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: {
          'campaignId': campaignId,
        },
      );
      // print(response.data);
      if (!response.data['error']) return true;
      return false;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> taskProof(int id, String? caption, XFile? photo) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post(
      '/proof',
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'multipart/form-data',
        },
      ),
      data: FormData.fromMap({
        'missionId': id,
        if (photo != null) 'photo': await MultipartFile.fromFile(photo.path),
        if (caption != null) 'caption': caption,
      }),
    );
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }

  static Future<bool> completeCampaign(int campaignId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post(
      '/completecampaign',
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      ),
      data: {
        'campaignId': campaignId,
      },
    );
    if (!response.data['error']) return true;
    throw ErrorDescription(response.data["message"]);
  }
}
