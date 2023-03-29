import 'package:flutter/material.dart';

import 'auth_theme.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({super.key, required this.text, required this.handler});
  final String text;
  final void Function() handler;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: handler,
      style: AuthTheme.textButtonTheme,
      child: Text(text),
    );
  }
}
