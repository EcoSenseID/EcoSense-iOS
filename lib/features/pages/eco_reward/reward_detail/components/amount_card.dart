import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class AmountCard extends StatelessWidget {
  const AmountCard(this.title, this.partner, {super.key});
  final String title;
  final String partner;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFCDEEDD),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.rubik(
                color: EcoSenseTheme.darkGreen,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'reward_redeem_provider_caption'.i18n(),
                  style: GoogleFonts.plusJakartaSans(
                    color: EcoSenseTheme.darkGreen,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  partner,
                  style: GoogleFonts.plusJakartaSans(
                    color: EcoSenseTheme.darkGreen,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
