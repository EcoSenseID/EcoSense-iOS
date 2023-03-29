import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoSenseTheme {
  static const green = Color(0xFF04B27F);
  static const secondary = Color(0xFF565656);
  static const lightGrey = Color(0xFFF8F8F8);
  static const darkGrey = Color(0xFFC8C8C8);
  static const grey = Color(0xFFF1F1F1);
  static const textGrey = Color(0xFFABABAB);
  static const darkerGrey = Color(0xFFA8A8A8);
  static const electricGreen = Color(0xFF1CBC00);
  static const darkGreen = Color(0xFF036C5C);
  static const superDarkGray = Color(0xFF6E6E6E);
  static const darkRed = Color(0xFF9B211B);
  static const orange = Color(0xFFFF8A15);
  static const mintGreen = Color(0xFFCDEEDD);
  static const custardYellow = Color(0xFFE2BA13);
  static const darkBlue = Color(0xFF004DC9);

  static const verticalGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF036C5C),
      Color(0xFF80B014),
    ],
  );

  static const horizontalGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFF036C5C),
      Color(0xFF80B014),
    ],
  );

  static final theme = ThemeData(
    primarySwatch: Colors.lightGreen,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      TextTheme(
        headline2: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w800,
          fontSize: 22,
        ),
        headline3: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
        headline4: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w800,
          fontSize: 15,
          color: Colors.black,
        ),
        bodyText1: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        subtitle2: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
        caption: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: lightGrey,
      foregroundColor: electricGreen,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w800,
        fontSize: 17,
        color: darkGreen,
      ),
    ),
  );

  static final tabBarTextTheme = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static final calloutTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  static final underDevelopmentTextStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  static final profileTextFieldStyle = InputDecoration(
    filled: true,
    fillColor: EcoSenseTheme.lightGrey,
    contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
    labelStyle:
        theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: EcoSenseTheme.darkGrey),
    ),
    hintStyle: const TextStyle(color: darkerGrey),
  );

  static final boxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(0, 0),
    blurRadius: 8,
  );
}
