import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AboutCampaign extends StatelessWidget {
  const AboutCampaign(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 14),
        Text(
          'profile_campaign_detail_about_section_title'.i18n(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          campaign.description,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
