import 'package:ecosense/features/pages/auth/components/auth_theme.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        validator: (value) => (value == "") ? "Must not be empty" : null,
        controller: controller,
        decoration: AuthTheme.formStyle.copyWith(labelText: hintText),
      ),
    );
  }
}
