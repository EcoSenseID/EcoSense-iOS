import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class RewardDescription extends StatelessWidget {
  const RewardDescription(this.description, {super.key});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'reward_redeem_description_section_title'.i18n(),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(decoration: TextDecoration.underline),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 12, color: const Color(0xFF6E6E6E)),
        ),
      ],
    );
  }
}
