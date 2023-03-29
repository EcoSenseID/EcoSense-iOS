import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import 'auth_theme.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({required this.handler, super.key});
  final void Function() handler;

  Widget _button() => InkWell(
        onTap: handler,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: Colors.black,
          ),
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.apple,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  "apple_sign_in".i18n(),
                  textAlign: TextAlign.center,
                  style:
                      AuthTheme.buttonTextTheme.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: TheAppleSignIn.isAvailable(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) return _button();
          return Container();
        }
        return Container();
      },
    );
  }
}
