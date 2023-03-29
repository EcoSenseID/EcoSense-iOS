import 'package:ecosense/features/pages/eco_reward/my_ecoreward/my_ecoreward.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';

class SubmittedReward extends StatelessWidget {
  const SubmittedReward({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/reward_checklist.png'),
            Text(
              'reward_redeem_success_notification_caption1'.i18n(),
              style: GoogleFonts.plusJakartaSans(fontSize: 15),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'reward_redeem_success_notification_caption2'.i18n(),
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 15, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'reward_redeem_success_notification_caption3'.i18n(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: const MyEcoReward());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: EcoSenseTheme.darkGreen),
                ),
                child: Center(
                  child: Text(
                    'reward_redeem_suff_notification_okay_button'.i18n(),
                    style: EcoSenseTheme.calloutTextStyle
                        .copyWith(color: EcoSenseTheme.darkGreen),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
