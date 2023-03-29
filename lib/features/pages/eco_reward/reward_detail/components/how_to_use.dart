import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class HowToUse extends StatelessWidget {
  const HowToUse(this.instructions, {super.key});
  final List<String> instructions;

  @override
  Widget build(BuildContext context) {
    int idx = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'reward_redeem_instruction_section_title'.i18n(),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(decoration: TextDecoration.underline),
        ),
        const SizedBox(height: 8),
        ...instructions.map((instruction) {
          idx++;
          return Text(
            '$idx. $instruction',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12, color: const Color(0xFF6E6E6E)),
          );
        }),
      ],
    );
  }
}
