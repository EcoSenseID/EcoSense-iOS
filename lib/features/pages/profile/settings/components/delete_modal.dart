import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/pages/profile/delete_account/delete_account.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DeleteAccountModal extends StatelessWidget {
  const DeleteAccountModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'profile_settings_delete_title1'.i18n(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: const Color(0xFF206A5D),
                height: 0.9,
              ),
            ),
            Text(
              'profile_settings_delete_title2'.i18n(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: EcoSenseTheme.darkRed,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'profile_settings_delete_capt'.i18n(),
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const DeleteAccountScreen());
                  },
                  child: Container(
                    width: 134,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: EcoSenseTheme.darkRed,
                    ),
                    child: Center(
                      child: Text(
                        'profile_setting_logout_notification_yes_button'.i18n(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 134,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: EcoSenseTheme.darkGreen),
                    ),
                    child: Center(
                      child: Text(
                        'login_cancel_button'.i18n(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: EcoSenseTheme.darkGreen,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
