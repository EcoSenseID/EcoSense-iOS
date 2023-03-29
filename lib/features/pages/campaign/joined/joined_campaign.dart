import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/joined/components/completed.dart';
import 'package:ecosense/features/pages/campaign/joined/components/joined_campaign_bottom.dart';
import 'package:ecosense/features/pages/campaign/joined/components/joined_tasks.dart';
import 'package:ecosense/features/pages/campaign/joined/components/rejected.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/theme.dart';
import '../detail/components/about_campaign.dart';
import '../detail/components/initiiator_end_time.dart';
import '../detail/components/photo_header.dart';

class JoinedCampaign extends StatelessWidget {
  const JoinedCampaign(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  Widget _shareCampaignButton(BuildContext context) => InkWell(
        onTap: () {
          Share.share(
              'https://ecosense.id/deeplinks/campaigndetail/${campaign.id}');
          // PersistentNavBarNavigator.pushNewScreen(context,
          //     screen: NewStoryScreen(
          //       campaign: SharedCampaign.fromCampaignDetail(campaign),
          //     ));
        },
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: EcoSenseTheme.darkGreen),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.share_outlined,
                  color: EcoSenseTheme.darkGreen,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'profile_campaign_detail_share_campaign_button'.i18n(),
                  style: EcoSenseTheme.calloutTextStyle.copyWith(
                    color: EcoSenseTheme.darkGreen,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            const SizedBox(height: 18),
            CampaignDetailPhotoHeader(campaign),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  InitiatorEndTime(campaign),
                  AboutCampaign(campaign),
                  JoinedTasks(campaign),
                  const SizedBox(height: 32),
                  if (campaign.completionStatus == 4) const CampaignRejected(),
                  if (campaign.completionStatus == 3)
                    CampaignCompletedCaption(campaign.earnedPoints ?? ''),
                  _shareCampaignButton(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: (campaign.canSubmit || !campaign.isOpen)
          ? JoinedCampaignBottom(campaign)
          : null,
    );
  }
}
