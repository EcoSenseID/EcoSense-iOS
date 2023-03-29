import 'package:dio/dio.dart';
import 'package:ecosense/data/models/my_reward_detail.dart';
import 'package:ecosense/data/models/my_reward_preview.dart';
import 'package:ecosense/data/models/reward_detail.dart';
import 'package:ecosense/data/models/reward_homepage.dart';
import 'package:ecosense/data/models/reward_list_item.dart';
import 'package:ecosense/services/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RewardService {
  static Future<RewardHomepage> rewardHome() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/rewardhome',
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data;

    if (!data['error']) {
      final rewardHome = RewardHomepage.fromJson(data);
      return rewardHome;
    }
    throw ErrorDescription(data['message']);
  }

  static Future<List<RewardListItem>> rewardList(int categoryId) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/rewards',
      queryParameters: {
        'categoryId': categoryId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data;
    if (!data['error']) {
      final List<RewardListItem> rewards = data['rewards']
          .map((reward) => RewardListItem.fromJson(reward))
          .toList()
          .cast<RewardListItem>();
      return rewards;
    }
    throw ErrorDescription(data['message']);
  }

  static Future<RewardDetail> rewardDetail(int rewardId) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await dio.get(
      '/rewarddetail',
      queryParameters: {
        'rewardId': rewardId,
      },
      options: Options(
        headers: {
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (!response.data['error']) {
      return RewardDetail.fromJson(rewardId, response.data);
    }
    throw ErrorDescription(response.data['message']);
  }

  static Future<List<MyRewardPreview>> myRewards() async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.get(
      '/myrewards',
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data;
    if (!data['error']) {
      final List<MyRewardPreview> rewards = data['myRewards']
          .map((reward) => MyRewardPreview.fromJson(reward))
          .toList()
          .cast<MyRewardPreview>();
      return rewards;
    }
    throw ErrorDescription(data['message']);
  }

  static Future<MyRewardDetailModel> myRewardDetail(int claimId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.get(
      '/myrewarddetail',
      queryParameters: {
        'claimId': claimId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      ),
    );
    if (!response.data['error']) {
      return MyRewardDetailModel.fromJson(response.data);
    }
    throw ErrorDescription(response.data['message']);
  }

  static Future<bool> redeemReward(int rewardId) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post(
      '/redeemreward',
      data: {
        'rewardId': rewardId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data;
    if (!data['error']) return true;
    throw ErrorDescription(data['message']);
  }

  static Future<bool> requestReward(int rewardId, String email,
      String walletType, String walletNumber) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.post(
      '/requestreward',
      data: {
        'rewardId': rewardId,
        'email': email,
        'walletType': walletType,
        'walletNumber': walletNumber,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final data = response.data;
    if (!data['error']) return true;
    throw ErrorDescription(data['message']);
  }
}
