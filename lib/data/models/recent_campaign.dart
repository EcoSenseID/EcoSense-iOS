import 'package:localization/localization.dart';

import 'campaign.dart';

class RecentCampaign {
  final int id;
  final int recordId;
  final String posterUrl;
  final String title;
  final DateTime? finishedAt;
  final int earnedPoints;
  final DateTime endAt;
  final int completionStatus;
  final List<CampaignCategory> categories;

  String get caption {
    if (finishedAt != null) {
      return 'profile_campaign_card_on_caption'.i18n();
    }
    if (DateTime.now().isBefore(endAt)) {
      return 'profile_campaign_detail_deadline_caption'.i18n();
    }
    return 'other_campaign_detail_over_button'.i18n();
  }

  DateTime get widgetDate {
    if (finishedAt != null) {
      return finishedAt!;
    }
    return endAt;
  }

  RecentCampaign.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        recordId = data['recordId'],
        posterUrl = data['posterUrl'],
        title = data['title'],
        endAt = DateTime.fromMillisecondsSinceEpoch(data['endAt'] * 1000),
        finishedAt = data['finishedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['finishedAt'] * 1000)
            : null,
        earnedPoints = data['earnedPoints'],
        completionStatus = data['completionStatus'],
        categories = List<CampaignCategory>.from(data['categories']
            .map((category) => CampaignCategory.fromJson(category)));

  // RecentCampaign.fromCampaignDetail(CampaignDetailModel campaign)
  //     : id = campaign.id,
  //       posterUrl = campaign.posterUrl,
  //       title = campaign.title,
  //       endAt = campaign.endDate,
  //       finishedAt = null,
  //       earnedPoints = 0,
  //       completionStatus = 0,
  //       categories = campaign.categories;
}
