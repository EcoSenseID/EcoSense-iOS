import 'package:ecosense/data/models/campaign.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/data/models/recent_campaign.dart';
import 'package:intl/intl.dart';

class StoryModel {
  final int id;
  final int userId;
  final String name;
  final String avatarUrl;
  final String caption;
  final String attachedPhotoUrl;
  final SharedCampaign? sharedCampaign;
  final int createdAt;
  final int supportersCount;
  final int repliesCount;
  final bool isSupported;
  final List<String> supportersAvatarsUrl;

  String get formattedDate {
    final date = DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);
    return DateFormat('dd MMM yy - hh.mm').format(date);
  }

  StoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        name = json['name'],
        avatarUrl = json['avatarUrl'],
        caption = json['caption'],
        attachedPhotoUrl = json['attachedPhotoUrl'],
        sharedCampaign = json['sharedCampaign'] != null
            ? SharedCampaign.fromJson(json['sharedCampaign'])
            : null,
        createdAt = json['createdAt'],
        supportersCount = json['supportersCount'],
        repliesCount = json['repliesCount'],
        isSupported = json['isSupported'],
        supportersAvatarsUrl = List<String>.from(json['supportersAvatarsUrl']);
}

class SharedCampaign {
  final int id;
  final String posterUrl;
  final String title;
  final DateTime endAt;
  final List<CampaignCategory> categories;
  final bool? isTrending;
  final bool? isNew;

  SharedCampaign.fromCampaignDetail(CampaignDetailModel campaignDetail)
      : id = campaignDetail.id,
        posterUrl = campaignDetail.posterUrl,
        title = campaignDetail.title,
        endAt = campaignDetail.endDate,
        categories = campaignDetail.categories,
        isTrending = campaignDetail.isTrending,
        isNew = campaignDetail.isNew;

  SharedCampaign.fromRecentCampaign(RecentCampaign campaign)
      : id = campaign.id,
        posterUrl = campaign.posterUrl,
        title = campaign.title,
        endAt = campaign.endAt,
        categories = campaign.categories,
        isTrending = null,
        isNew = null;

  SharedCampaign.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        posterUrl = json['posterUrl'],
        title = json['title'],
        endAt = DateTime.fromMillisecondsSinceEpoch(
            (json['endDate'] ?? json['endAt']) * 1000),
        categories = List<CampaignCategory>.from(
          json['categories'].map(
            (category) => CampaignCategory.fromJson(category),
          ),
        ),
        isTrending = json['isTrending'],
        isNew = json['isNew'];
}
