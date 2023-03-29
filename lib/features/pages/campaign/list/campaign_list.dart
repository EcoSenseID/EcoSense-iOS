import 'package:ecosense/data/models/campaign.dart';
import 'package:ecosense/data/models/category.dart';
import 'package:ecosense/features/pages/campaign/list/components/loaded_campaigns.dart';
import 'package:ecosense/services/campaign/campaign_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CampaignListScreen extends StatefulWidget {
  const CampaignListScreen(this.category, {super.key});

  final CategoryModel? category;

  @override
  State<CampaignListScreen> createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  late Future<List<Campaign>> _campaignsFuture;

  @override
  void initState() {
    _campaignsFuture =
        CampaignService.campaigns(categoryId: widget.category?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.category?.name ?? 'campaign_campaign_list_title'.i18n())),
      body: FutureBuilder(
        future: _campaignsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('went_wrong'.i18n()));
          }
          if (snapshot.hasData) {
            return LoadedCampaigns(snapshot.data! as List<Campaign>);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
