import 'package:ecosense/data/models/reward_preview.dart';

class RewardHomepage {
  final int totalPoints;
  final List<RewardPreview> walletRewards;
  final List<RewardPreview> donationRewards;

  RewardHomepage.fromJson(Map<String, dynamic> json)
      : totalPoints = json['totalPoints'],
        walletRewards = json['walletRewards']
            .map<RewardPreview>(
                (walletReward) => RewardPreview.fromJson(walletReward))
            .toList(),
        donationRewards = json['donationRewards']
            .map<RewardPreview>(
                (donationReward) => RewardPreview.fromJson(donationReward))
            .toList();
}
