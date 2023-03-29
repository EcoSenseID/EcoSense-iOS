import 'package:ecosense/data/models/story.dart';

import 'recent_campaign.dart';

class OthersProfileModel {
  final int userId;
  final String name;
  final String avatarUrl;
  final List<StoryModel> recentStories;
  final List<RecentCampaign> recentCampaigns;

  OthersProfileModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'],
        avatarUrl = json['avatarUrl'],
        recentStories = json['recentStories']
            .map<StoryModel>((story) => StoryModel.fromJson(story))
            .toList(),
        recentCampaigns = json['recentCampaigns']
            .map<RecentCampaign>(
                (campaign) => RecentCampaign.fromJson(campaign))
            .toList();
}
