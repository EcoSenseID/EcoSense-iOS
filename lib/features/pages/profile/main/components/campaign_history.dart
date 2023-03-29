import 'package:ecosense/data/models/recent_campaign.dart';
import 'package:ecosense/features/pages/profile/campaign_history/campaign_history_screen.dart';
import 'package:ecosense/features/pages/profile/main/components/recent_campaign_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';

class CampaignHistory extends StatelessWidget {
  const CampaignHistory(this.campaigns, {this.userId, super.key});
  final int? userId;
  final List<RecentCampaign> campaigns;

  Widget _noCampaign(BuildContext context) => Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Image.asset(
            'assets/images/Character-04.png',
            width: 110,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'profile_nopost_caption'.i18n(),
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(children: [
            Text(
              userId == null
                  ? 'profile_campaign_title'.i18n()
                  : 'other_main_history_section_title'.i18n(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.black),
            ),
            const Spacer(),
            TextButton(
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CampaignHistoryScreen(userId: userId)),
                child: Text(
                  'profile_see_all_button'.i18n(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: EcoSenseTheme.darkGreen,
                  ),
                )),
          ]),
        ),
        campaigns.isEmpty
            ? _noCampaign(context)
            : Column(
                children: campaigns
                    .map((campaign) => RecentCampaignWidget(campaign))
                    .toList(),
              ),
      ],
    );
  }
}
