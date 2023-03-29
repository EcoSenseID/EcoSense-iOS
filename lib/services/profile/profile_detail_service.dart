import 'package:dio/dio.dart';
import 'package:ecosense/data/models/others_profile.dart';
import 'package:ecosense/data/models/profile.dart';
import 'package:ecosense/data/models/recent_campaign.dart';
import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/services/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileDetailService {
  static Future<ProfileModel> profileDetail({int? userId}) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/profile',
      queryParameters: {
        if (userId != null) 'userId': userId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (!response.data['error']) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message']);
    }
  }

  static Future<OthersProfileModel> getOthersProfile(int userId) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/profile',
      queryParameters: {
        'userId': userId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (!response.data['error']) {
      return OthersProfileModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message']);
    }
  }

  static Future<List<StoryModel>> getRecentPost({int? userId}) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/storieshistory',
      queryParameters: {
        if (userId != null) 'userId': userId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (!response.data['error']) {
      return (response.data['stories'] as List)
          .map((e) => StoryModel.fromJson(e))
          .toList();
    } else {
      throw ErrorDescription(response.data['message']);
    }
  }

  static Future<List<RecentCampaign>> getRecentCampaign({int? userId}) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/campaignshistory',
      queryParameters: {
        if (userId != null) 'userId': userId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (!response.data['error']) {
      return (response.data['campaigns'] as List)
          .map((e) => RecentCampaign.fromJson(e))
          .toList();
    } else {
      throw ErrorDescription(response.data['message']);
    }
  }
}
