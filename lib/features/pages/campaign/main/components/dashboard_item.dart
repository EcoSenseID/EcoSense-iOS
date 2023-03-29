import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/dashboard.dart';
import 'package:ecosense/features/pages/campaign/detail/campaign_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem(this.campaign, {super.key});
  final CampaignDashboardModel campaign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: CampaignDetailScreen(campaign.id), withNavBar: false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 18),
          Container(
            width: 300,
            height: 146,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: EcoSenseTheme.mintGreen,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [EcoSenseTheme.boxShadow],
            ),
            child: Column(
              children: [
                Text(
                  campaign.name,
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: EcoSenseTheme.darkGreen,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      height: 85,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: EcoSenseTheme.orange,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${campaign.missionLeft}',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 42,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1),
                          ),
                          Text(
                            'campaign_main_campaign_task_togo'.i18n(),
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 85,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: EcoSenseTheme.verticalGradient,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${campaign.missionCompleted}',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 42,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1),
                          ),
                          Text(
                            'campaign_main_campaign_task_completed'.i18n(),
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 340,
              maxHeight: 165,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [EcoSenseTheme.boxShadow],
              ),
              child: campaign.missionLeft == 0
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: EcoSenseTheme.mintGreen,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [EcoSenseTheme.boxShadow],
                      ),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            'hore'.i18n(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: EcoSenseTheme.darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image.asset('assets/images/Character-04.png'),
                        )
                      ]),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: campaign.missionLeft,
                      itemBuilder: (context, index) {
                        final mission = campaign.uncompletedMissions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mission.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: EcoSenseTheme.darkGreen,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                campaign.name,
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF81B214)),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'campaign_main_task_dayleft'.i18n([
                                      '${campaign.daysLeft}',
                                    ]),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                      '${'campaign_main_task_deadline'.i18n()} ${campaign.until}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
