import 'package:ecosense/features/pages/profile/settings/components/delete_modal.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  void _deletePressed(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => const DeleteAccountModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _deletePressed(context),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: EcoSenseTheme.darkRed,
        ),
        child: Center(
            child: Text(
          'profile_settings_delete_button'.i18n(),
          style: EcoSenseTheme.calloutTextStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
