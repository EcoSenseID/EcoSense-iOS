import 'dart:async';

import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/pages/profile/settings/components/about.dart';
import 'package:ecosense/features/pages/profile/settings/components/account_settings.dart';
import 'package:ecosense/features/pages/profile/settings/components/delete_acc_button.dart';
import 'package:ecosense/features/pages/profile/settings/components/log_out_button.dart';
import 'package:ecosense/features/pages/profile/settings/components/profile_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late StreamSubscription<User?> _userSubscription;

  @override
  void initState() {
    _userSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Phoenix.rebirth(context);
        // Navigator.of(context).popUntil((route) => route.isFirst);
        // Navigator.of(context).popAndPushNamed(Routes.login);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  AppBar _appBar() => AppBar(
        title: const Text('Settings'),
      );

  Widget _findUs() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'profile_setting_findus_caption'.i18n(),
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _findUsItem(
                  'instagram.svg', 'https://www.instagram.com/ecosense.id/'),
              const SizedBox(width: 8),
              _findUsItem('website.svg', 'https://ecosense.id/'),
              const SizedBox(width: 8),
              _findUsItem('linkedin.svg',
                  'https://www.linkedin.com/company/ecosense-indonesia/'),
            ],
          )
        ],
      );

  Widget _findUsItem(String svgFileName, String url) => InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          await launchUrl(uri);
        },
        child: CircleAvatar(
          radius: 19,
          backgroundColor: EcoSenseTheme.grey,
          child: SvgPicture.asset('assets/svgs/$svgFileName'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const ProfileDetailHorizontal(),
            const SizedBox(height: 36),
            const AccountSettings(),
            const SizedBox(height: 24),
            // const ApplicationLanguageWidget(),
            // const SizedBox(height: 24),
            const AboutEcoSense(),
            const SizedBox(height: 31),
            const LogOutButton(),
            const SizedBox(height: 12),
            const DeleteAccountButton(),
            const SizedBox(height: 22),
            _findUs(),
          ],
        ),
      ),
    );
  }
}
