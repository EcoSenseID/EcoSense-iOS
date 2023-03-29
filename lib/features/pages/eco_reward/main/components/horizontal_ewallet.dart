import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../../data/models/reward_preview.dart';
import '../../list/reward_list.dart';
import '../../reward_detail/reward_detail.dart';

class HorizontalEwallet extends StatelessWidget {
  const HorizontalEwallet(this.rewards, this.currentPoint, {super.key});
  final List<RewardPreview> rewards;
  final int currentPoint;

  Widget _title(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'E-Wallet',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black),
            ),
            GestureDetector(
              onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                  screen: RewardListScreen(1, 'E-Wallet', currentPoint)),
              child: Row(
                children: [
                  Text('other_main_see_all_button'.i18n(),
                      style: const TextStyle(color: EcoSenseTheme.darkGreen)),
                  const Icon(Icons.keyboard_arrow_right,
                      color: EcoSenseTheme.darkGreen),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _rewardCard(RewardPreview reward, BuildContext context) => InkWell(
        onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
            screen: RewardDetailScreen(reward.id, reward.title, currentPoint),
            withNavBar: false),
        child: Container(
          margin: const EdgeInsets.all(8),
          width: 184,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: EcoSenseTheme.grey,
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18)),
                child: CachedNetworkImage(
                  imageUrl: reward.bannerUrl,
                  height: 70,
                  width: 184,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      reward.title,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reward.partner,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: const Color(0xFF6E6E6E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/ecopoint.svg',
                          width: 11,
                          color: EcoSenseTheme.darkGreen,
                        ),
                        Text(
                          ' ${NumberFormat.decimalPattern('id-id').format(reward.pointsNeeded)}',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: EcoSenseTheme.darkGreen),
                        ),
                        Text(
                          ' EcoPoints',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 14),
        _title(context),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 174),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: rewards.length,
            itemBuilder: (context, index) =>
                _rewardCard(rewards[index], context),
          ),
        ),
      ],
    );
  }
}
