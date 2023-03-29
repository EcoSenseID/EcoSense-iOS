import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MyRewardPreview {
  final int claimId;
  final String bannerUrl;
  final String title;
  final String partner;
  final String category;
  final int claimStatus;

  String get status {
    switch (claimStatus) {
      case 2:
        return 'reward_redeem_request_button'.i18n();
      case 3:
        return 'reward_redeem_completed_button'.i18n();
      default:
        return '';
    }
  }

  Color get color {
    switch (claimStatus) {
      case 2:
        return EcoSenseTheme.custardYellow;
      case 3:
        return EcoSenseTheme.superDarkGray;
      default:
        return Colors.white;
    }
  }

  MyRewardPreview.fromJson(Map<String, dynamic> json)
      : claimId = json['claimId'],
        bannerUrl = json['bannerUrl'],
        title = json['title'],
        partner = json['partner'],
        category = json['category'],
        claimStatus = json['claimStatus'];
}
