import 'package:ecosense/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class Campaign {
  final int id;
  final String posterUrl;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<CampaignCategory> categories;
  final int participantsCount;
  final bool isTrending;
  final bool isNew;

  String get dateCaption {
    if (DateTime.now().isBefore(startDate)) {
      return 'campaign_campaign_list_start'.i18n();
    }
    if (DateTime.now().isBefore(endDate)) {
      return 'campaign_campaign_list_deadline'.i18n();
    }
    return 'profile_campaign_detail_status_end'.i18n();
  }

  DateTime get displayDate {
    if (DateTime.now().isBefore(startDate)) {
      return startDate;
    }
    return endDate;
  }

  Campaign.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        posterUrl = data['posterUrl'],
        title = data['title'],
        startDate =
            DateTime.fromMillisecondsSinceEpoch(data['startDate'] * 1000),
        endDate = DateTime.fromMillisecondsSinceEpoch(data['endDate'] * 1000),
        categories = data['categories']
            .map((category) => CampaignCategory.fromJson(category))
            .toList()
            .cast<CampaignCategory>(),
        participantsCount = data['participantsCount'],
        isTrending = data['isTrending'],
        isNew = data['isNew'];
}

class CampaignCategory {
  final String name;
  final Color color;

  CampaignCategory.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        color = HexColor.fromHex(data['colorHex']);
}
