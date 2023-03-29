import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../../services/auth/auth_service.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  void _logOutPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('profile_setting_logout_notification_caption'.i18n()),
        actions: [
          CupertinoDialogAction(
            onPressed: Navigator.of(context).pop,
            child: Text('login_cancel_button'.i18n()),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: AuthService.signOut,
            child: Text('profile_setting_logout_button'.i18n()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _logOutPressed(context),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: EcoSenseTheme.darkRed),
          color: Colors.white,
        ),
        child: Center(
            child: Text(
          'profile_setting_logout_button'.i18n(),
          style: EcoSenseTheme.calloutTextStyle
              .copyWith(color: EcoSenseTheme.darkRed),
        )),
      ),
    );
  }
}
