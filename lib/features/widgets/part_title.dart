import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartTitle extends StatelessWidget {
  const PartTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            decoration: TextDecoration.underline));
  }
}
