import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/detail/components/about_campaign.dart';
import 'package:ecosense/features/pages/campaign/detail/components/campaign_tasks.dart';
import 'package:ecosense/features/pages/campaign/detail/components/initiiator_end_time.dart';
import 'package:ecosense/features/pages/campaign/detail/components/join_campaign.dart';
import 'package:ecosense/features/pages/campaign/detail/components/photo_header.dart';
import 'package:ecosense/features/pages/campaign/joined/joined_campaign.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:share_plus/share_plus.dart';

class LoadedCampaignDetail extends StatelessWidget {
  const LoadedCampaignDetail(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  Widget _shareCampaignButton(BuildContext context) => InkWell(
        onTap: () {
          Share.share(
              'https://ecosense.id/deeplinks/campaigndetail/${campaign.id}');
          // if (!AuthService.isLoggedIn()) {
          //   Toasts.showFailedToast('must_log_in'.i18n(), context);
          //   return;
          // }
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
    if (campaign.joined) return JoinedCampaign(campaign);
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
                  CampaignTasks(campaign),
                  const SizedBox(height: 32),
                  _shareCampaignButton(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: JoinCampaignBar(campaign),
    );
  }
}
