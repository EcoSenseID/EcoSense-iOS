import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/reward_list_item.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/reward_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';

class RewardItemWidget extends ConsumerWidget {
  const RewardItemWidget(this.reward, this.currentPoint, {super.key});
  final RewardListItem reward;
  final int currentPoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: RewardDetailScreen(reward.id, reward.title, currentPoint),
          withNavBar: false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        width: double.infinity,
        height: 146,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: EcoSenseTheme.darkGrey),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: reward.bannerUrl,
                width: 160,
                height: 146,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    reward.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reward.partner,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, color: const Color(0xFF6E6E6E)),
                  ),
                  const Spacer(),
                  Container(
                    height: 22,
                    width: double.infinity,
                    margin: const EdgeInsets.only(right: 12, bottom: 12),
                    decoration: BoxDecoration(
                      gradient: EcoSenseTheme.verticalGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Redeem',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          SvgPicture.asset('assets/svgs/ecopoint.svg',
                              height: 11),
                          Text(
                            ' ${reward.pointsNeeded}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: const Color(0xFFD5F299),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'Eco Points',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
