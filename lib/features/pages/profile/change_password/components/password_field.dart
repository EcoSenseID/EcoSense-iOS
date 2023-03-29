import 'package:flutter/material.dart';

import '../../../../../core/constants/theme.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _visible = false;

  void _changeVisibility() => setState(() {
        _visible = !_visible;
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: 10),
        TextField(
          obscureText: !_visible,
          controller: widget.controller,
          decoration: EcoSenseTheme.profileTextFieldStyle.copyWith(
              hintText: widget.label,
              suffixIcon: IconButton(
                onPressed: _changeVisibility,
                icon: Icon(_visible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              )),
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
