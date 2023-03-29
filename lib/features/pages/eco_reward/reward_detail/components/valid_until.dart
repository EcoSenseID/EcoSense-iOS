import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

class ValidUntil extends StatelessWidget {
  const ValidUntil(this.validUntil, {super.key});
  final DateTime validUntil;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'reward_redeem_valid_section_title'.i18n(),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(decoration: TextDecoration.underline),
        ),
        const SizedBox(height: 8),
        Text(
          DateFormat("dd MMMM yyyy").format(validUntil),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: EcoSenseTheme.darkGreen),
        ),
      ],
    );
  }
}
