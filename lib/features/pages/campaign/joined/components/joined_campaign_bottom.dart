// ignore_for_file: use_build_context_synchronously

import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/detail/campaign_detail_provider.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/services/campaign/campaign_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:share_plus/share_plus.dart';

class JoinedCampaignBottom extends ConsumerWidget {
  const JoinedCampaignBottom(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  Widget get _endedCampaign => Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 36),
        decoration: BoxDecoration(
          color: EcoSenseTheme.darkerGrey,
          borderRadius: BorderRadius.circular(70),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            'profile_campaign_detail_status_end'.i18n(),
            textAlign: TextAlign.center,
            style: EcoSenseTheme.calloutTextStyle.copyWith(color: Colors.white),
          ),
        ),
      );

  Widget _finishCampaign(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        showDialog(context: context, builder: (_) => const Loading());
        await CampaignService.completeCampaign(campaign.id);
        Navigator.pop(context);
        ref.read(campaignDetailProvider.notifier).state++;
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 36),
        decoration: BoxDecoration(
          gradient: EcoSenseTheme.verticalGradient,
          borderRadius: BorderRadius.circular(70),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            'profile_campaign_detail_statu_finish'.i18n(),
            textAlign: TextAlign.center,
            style: EcoSenseTheme.calloutTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget get _inVerification => Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 36),
        decoration: BoxDecoration(
          color: EcoSenseTheme.custardYellow,
          borderRadius: BorderRadius.circular(70),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            'profile_campaign_detail_status_inverif'.i18n(),
            textAlign: TextAlign.center,
            style: EcoSenseTheme.calloutTextStyle.copyWith(color: Colors.white),
          ),
        ),
      );

  Widget _resubmit(BuildContext context, WidgetRef ref) => InkWell(
        onTap: () async {
          showDialog(context: context, builder: (_) => const Loading());
          await CampaignService.completeCampaign(campaign.id);
          Navigator.pop(context);
          ref.read(campaignDetailProvider.notifier).state++;
        },
        child: Container(
          height: 50,
          margin:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 36),
          decoration: BoxDecoration(
            color: EcoSenseTheme.darkBlue,
            borderRadius: BorderRadius.circular(70),
          ),
          width: double.infinity,
          child: Center(
            child: Text(
              'profile_campaign_detail_status_resubmit'.i18n(),
              textAlign: TextAlign.center,
              style:
                  EcoSenseTheme.calloutTextStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      );

  Widget _share(BuildContext context) => InkWell(
        onTap: () async {
          Share.share(
              'https://ecosense.id/deeplinks/campaigndetail/${campaign.id}');
          // PersistentNavBarNavigator.pushNewScreen(context,
          //     screen: NewStoryScreen(
          //       campaign: SharedCampaign.fromCampaignDetail(campaign),
          //     ));
        },
        child: Container(
          height: 50,
          margin:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 36),
          decoration: BoxDecoration(
            gradient: EcoSenseTheme.verticalGradient,
            borderRadius: BorderRadius.circular(70),
          ),
          width: double.infinity,
          child: Center(
            child: Text(
              'profile_campaign_detail_status_share'.i18n(),
              textAlign: TextAlign.center,
              style:
                  EcoSenseTheme.calloutTextStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      );

  Widget _perStatus(BuildContext context, WidgetRef ref) {
    if (campaign.completionStatus == 4) return _resubmit(context, ref);
    if (campaign.completionStatus == 3) return _share(context);
    if (campaign.completionStatus == 2) return _inVerification;
    if (campaign.completionStatus == 1) return _finishCampaign(context, ref);
    return Container();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [EcoSenseTheme.boxShadow],
        color: Colors.white,
      ),
      child: campaign.isOpen ? _perStatus(context, ref) : _endedCampaign,
    );
  }
}
