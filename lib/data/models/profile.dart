import 'package:ecosense/data/models/recent_campaign.dart';
import 'package:ecosense/data/models/story.dart';

class ProfileModel {
  final int totalEcoPoints;
  final List<StoryModel> recentStories;
  final List<RecentCampaign> recentCampaigns;

  ProfileModel.fromJson(Map<String, dynamic> json)
      : totalEcoPoints = json['totalEcoPoints'],
        recentStories = json['recentStories']
            .map<StoryModel>((story) => StoryModel.fromJson(story))
            .toList(),
        recentCampaigns = json['recentCampaigns']
            .map<RecentCampaign>(
                (campaign) => RecentCampaign.fromJson(campaign))
            .toList();
}
