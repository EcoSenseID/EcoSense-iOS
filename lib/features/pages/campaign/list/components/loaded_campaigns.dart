import 'package:ecosense/data/models/campaign.dart';
import 'package:ecosense/features/pages/campaign/list/components/campaign_card.dart';
import 'package:flutter/material.dart';

class LoadedCampaigns extends StatelessWidget {
  const LoadedCampaigns(this.campaigns, {super.key});

  final List<Campaign> campaigns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) => CampaignCard(campaigns[index]),
      ),
    );
  }
}
