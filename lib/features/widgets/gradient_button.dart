import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/pages/auth/components/auth_theme.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.text, required this.handler});

  final String text;
  final void Function() handler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handler,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: EcoSenseTheme.verticalGradient,
          borderRadius: BorderRadius.circular(70),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AuthTheme.buttonTextTheme.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
