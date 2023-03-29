import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../core/constants/theme.dart';

class MyRewardDetailModel {
  final String bannerUrl;
  final String title;
  final String partner;
  final DateTime validity;
  final String description;
  final List<String> termsCondition;
  final List<String> howToUse;
  final int claimStatus;
  final String category;

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

  MyRewardDetailModel.fromJson(Map<String, dynamic> json)
      : bannerUrl = json['bannerUrl'],
        title = json['title'],
        partner = json['partner'],
        validity = DateTime.fromMillisecondsSinceEpoch(json['validity'] * 1000),
        description = json['description'],
        termsCondition = List<String>.from(json['termsCondition']),
        howToUse = List<String>.from(json['howToUse']),
        claimStatus = json['claimStatus'],
        category = json['category'];
}
