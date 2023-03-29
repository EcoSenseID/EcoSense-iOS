import 'package:ecosense/data/models/recent_campaign.dart';
import 'package:ecosense/features/pages/profile/main/components/recent_campaign_widget.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../services/profile/profile_detail_service.dart';
import '../../../widgets/something_went_wrong.dart';

class CampaignHistoryScreen extends StatefulWidget {
  const CampaignHistoryScreen({this.userId, super.key});
  final int? userId;

  @override
  State<CampaignHistoryScreen> createState() => _CampaignHistoryScreenState();
}

class _CampaignHistoryScreenState extends State<CampaignHistoryScreen> {
  late Future<List<RecentCampaign>> _campaignsFuture;

  @override
  void initState() {
    _campaignsFuture =
        ProfileDetailService.getRecentCampaign(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.userId == null
              ? 'profile_history_section_title'.i18n()
              : 'other_main_history_section_title'.i18n())),
      body: FutureBuilder<List<RecentCampaign>>(
        future: _campaignsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final campaigns = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView.builder(
                itemCount: campaigns.length,
                itemBuilder: (context, index) {
                  final campaign = campaigns[index];
                  return RecentCampaignWidget(campaign);
                },
              ),
            );
          }
          if (snapshot.hasError) return const SomethingWentWrong();
          return const Loading();
        },
      ),
    );
  }
}
