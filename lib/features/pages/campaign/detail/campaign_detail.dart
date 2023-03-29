import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/detail/campaign_detail_provider.dart';
import 'package:ecosense/features/pages/campaign/detail/components/loaded_campaign_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';

import '../../../../services/campaign/campaign_service.dart';

class CampaignDetailScreen extends ConsumerWidget {
  const CampaignDetailScreen(this.campaignId, {this.recordId, super.key});
  final int campaignId;
  final int? recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(campaignDetailProvider);
    return Scaffold(
      appBar: AppBar(title: Text('profile_campaign_detail_title'.i18n())),
      body: FutureBuilder<CampaignDetailModel>(
        future: CampaignService.getCampaign(campaignId, recordId: recordId),
        builder: (context, snapshot) {
          if (snapshot.hasData) return LoadedCampaignDetail(snapshot.data!);
          if (snapshot.hasError) {
            return Center(
              child: Text('went_wrong'.i18n()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
