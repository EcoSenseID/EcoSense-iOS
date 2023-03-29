import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CampaignCompletedCaption extends StatelessWidget {
  const CampaignCompletedCaption(this.points, {super.key});
  final String points;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'profile_campaign_detail_congrat_caption'.i18n(),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          'profile_campaign_detail_congrats_caption2'.i18n([points]),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
