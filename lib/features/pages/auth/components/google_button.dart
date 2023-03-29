import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../core/constants/theme.dart';
import 'auth_theme.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.handler});
  final void Function() handler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handler,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            border: Border.all(color: EcoSenseTheme.green)),
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/google_logo.png'),
              const SizedBox(width: 8),
              Text(
                "login_google_button_caption".i18n(),
                textAlign: TextAlign.center,
                style: AuthTheme.buttonTextTheme.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
