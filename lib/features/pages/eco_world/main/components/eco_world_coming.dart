import 'package:ecosense/features/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class EcoWorldComingSoon extends StatelessWidget {
  const EcoWorldComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Character-02.png',
              width: 190,
            ),
            GradientText(
              'ecoWorld_get_ready'.i18n(),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'ecoWorld_coming'.i18n(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
