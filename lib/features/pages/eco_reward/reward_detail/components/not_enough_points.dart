import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/small_gradient_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class NotEnoughPoint extends ConsumerWidget {
  const NotEnoughPoint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'reward_redeem_suff_notificaton_title'.i18n(),
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  ' EcoPoints',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: EcoSenseTheme.electricGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'reward_redeem_suff_notification_caption'.i18n(),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 22),
            SmallGradientButton(
                'reward_redeem_suff_notification_okay_button'.i18n(),
                Navigator.of(context).pop),
          ],
        ),
      ),
    );
  }
}
