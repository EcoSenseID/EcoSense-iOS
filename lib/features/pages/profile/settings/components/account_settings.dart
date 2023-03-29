import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/pages/profile/change_password/change_password.dart';
import 'package:ecosense/features/pages/profile/edit_profile/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  Widget _settingsTile(
          String text, String svgFileName, void Function() handler) =>
      InkWell(
        onTap: handler,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.only(left: 14, right: 12),
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: EcoSenseTheme.darkGrey)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svgs/$svgFileName'),
              const SizedBox(width: 12),
              Text(text, style: EcoSenseTheme.calloutTextStyle),
              Expanded(child: Container()),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('profile_setting_account_section_title'.i18n(),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  decoration: TextDecoration.underline,
                )),
        const SizedBox(height: 8),
        _settingsTile(
          'profile_edit_profile_title'.i18n(),
          'editprofile.svg',
          () => PersistentNavBarNavigator.pushNewScreen(context,
              screen: const EditProfileScreen()),
        ),
        if (FirebaseAuth.instance.currentUser!.providerData
            .any((element) => element.providerId == 'password'))
          _settingsTile(
              'profile_setting_change_pass_button'.i18n(),
              'password.svg',
              () => PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const ChangePasswordScreen())),
      ],
    );
  }
}
