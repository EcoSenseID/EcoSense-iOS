import 'package:ecosense/data/models/campaign.dart';
import 'package:flutter/material.dart';

import '../../core/constants/theme.dart';

class CampaignDetailModel {
  final int id;
  final int participantsCount;
  final List<CampaignCategory> categories;
  final String title;
  final String posterUrl;
  final bool isTrending;
  final bool isNew;
  final String initiator;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final bool joined;
  final List<CampaignMission> missions;
  final int completionStatus;
  final String? earnedPoints;

  bool get isOpen => DateTime.now().isBefore(endDate);

  bool get canSubmit {
    for (final mission in missions) {
      if (mission.completionStatus == 1) return false;
    }
    return true;
  }

  CampaignDetailModel.fromJson(this.id, Map<String, dynamic> json)
      : participantsCount = json['participantsCount'],
        categories = json['categories']
            .map((category) => CampaignCategory.fromJson(category))
            .toList()
            .cast<CampaignCategory>(),
        title = json['title'],
        posterUrl = json['posterUrl'],
        isTrending = json['isTrending'],
        isNew = json['isNew'],
        initiator = json['initiator'],
        startDate =
            DateTime.fromMillisecondsSinceEpoch(json['startDate'] * 1000),
        endDate = DateTime.fromMillisecondsSinceEpoch(json['endDate'] * 1000),
        description = json['description'],
        joined = json['joined'],
        missions = json['missions']
            .map<CampaignMission>((task) => CampaignMission.fromJson(task))
            .toList(),
        completionStatus = json['completionStatus'],
        earnedPoints = json['earnedPoints'];
}

class CampaignMission {
  final int id;
  final String name;
  final String? photoUrl;
  final String? description;
  final bool? completed;
  final String? proofCaption;
  DateTime? completedTimeStamp;
  final int completionStatus;

  Color get color {
    switch (completionStatus) {
      case 1:
        return EcoSenseTheme.darkerGrey;
      case 2:
        return EcoSenseTheme.electricGreen;
      case 3:
        return EcoSenseTheme.electricGreen;
      case 4:
        return EcoSenseTheme.darkRed;
      default:
        return EcoSenseTheme.darkerGrey;
    }
  }

  IconData get icon {
    switch (completionStatus) {
      case 4:
        return Icons.cancel;
      default:
        return Icons.check_circle;
    }
  }

  CampaignMission.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        completed = json['completed'],
        proofCaption = json['proofCaption'],
        photoUrl = json['proofPhotoUrl'],
        completionStatus = json['completionStatus'] {
    if (json['completedTimeStamp'] != null) {
      completedTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
          json['completedTimeStamp'] ?? 0 * 1000);
    }
  }
}
