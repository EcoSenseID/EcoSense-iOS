import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTheme {
  static final h1 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w800,
    fontSize: 34,
    height: 1.1,
  );

  static final formLabel = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: EcoSenseTheme.darkerGrey,
  );

  static var formStyle = InputDecoration(
    filled: true,
    fillColor: EcoSenseTheme.lightGrey,
    contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
    labelStyle: formLabel,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: EcoSenseTheme.darkGrey),
    ),
  );

  static var textButtonTheme = TextButton.styleFrom(
    foregroundColor: EcoSenseTheme.electricGreen,
    textStyle: GoogleFonts.plusJakartaSans(
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
  );

  static var buttonTextTheme = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );

  static var body1 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  static var body2 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static var sub1 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );
}
