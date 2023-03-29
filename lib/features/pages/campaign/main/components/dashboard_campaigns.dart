import 'package:ecosense/data/models/dashboard.dart';
import 'package:ecosense/features/pages/campaign/main/components/categories.dart';
import 'package:ecosense/features/pages/campaign/main/components/dashboard_item.dart';
import 'package:ecosense/features/pages/campaign/main/components/no_campaign.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DashboardCampaigns extends StatelessWidget {
  const DashboardCampaigns(this.campaigns, {super.key});
  final List<CampaignDashboardModel> campaigns;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 18),
        Text(
          'campaign_main_caption'.i18n(),
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        campaigns.isEmpty
            ? const NoCampaignDashboard()
            : ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 380),
                child: ListView.builder(
                  itemCount: campaigns.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      DashboardItem(campaigns[index]),
                ),
              ),
        const Categories(),
      ],
    );
  }
}
