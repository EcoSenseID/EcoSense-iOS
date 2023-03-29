import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../auth/login.dart';

class NotLoggedInDashboard extends StatelessWidget {
  const NotLoggedInDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/Character-05.png', width: 160),
            const SizedBox(height: 4),
            Text('campaign_main_unlogin_caption'.i18n(),
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: const LoginScreen(), withNavBar: false);
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: EcoSenseTheme.verticalGradient,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                    child: Text(
                  'login_login_button_caption'.i18n(),
                  style: EcoSenseTheme.calloutTextStyle
                      .copyWith(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
