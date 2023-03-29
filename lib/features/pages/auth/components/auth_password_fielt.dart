import 'package:flutter/material.dart';

import 'auth_theme.dart';

class AuthPasswordField extends StatefulWidget {
  const AuthPasswordField(
      {super.key,
      required this.label,
      required this.controller,
      this.validator});

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscureText = true;

  void _changeVisibility() => setState(() {
        _obscureText = !_obscureText;
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText,
        decoration: AuthTheme.formStyle.copyWith(
            labelText: widget.label,
            suffixIcon: IconButton(
              onPressed: _changeVisibility,
              icon: Icon(_obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined),
            )),
      ),
    );
  }
}
