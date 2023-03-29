import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';

class CampaignRejected extends StatelessWidget {
  const CampaignRejected({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'profile_campaign_detail_status_rejected'.i18n(),
          style: GoogleFonts.plusJakartaSans(
            color: EcoSenseTheme.darkRed,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'profile_campaign_detail_status_rejected_caption'.i18n(),
          style: GoogleFonts.plusJakartaSans(
            color: EcoSenseTheme.darkRed,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
