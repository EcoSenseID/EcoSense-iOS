import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallOutlinedButton extends StatelessWidget {
  const SmallOutlinedButton(this.text, this.onPressed, {super.key});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 136,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: EcoSenseTheme.darkRed)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: EcoSenseTheme.darkRed,
            ),
          ),
        ),
      ),
    );
  }
}
