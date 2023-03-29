import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../auth/login.dart';
import '../../my_ecoreward/my_ecoreward.dart';

class RewardHeader extends StatelessWidget {
  const RewardHeader(this.totalPoints, {super.key});
  final int totalPoints;

  Widget _headerAction(BuildContext context, String label, String svgName,
          VoidCallback handler) =>
      InkWell(
        onTap: handler,
        child: Container(
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svgs/$svgName'),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    color: EcoSenseTheme.darkGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: EcoSenseTheme.darkGreen,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 148,
      decoration: const BoxDecoration(
        gradient: EcoSenseTheme.verticalGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!AuthService.isLoggedIn()) ...[
              Row(
                children: [
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'reward_main_unlogin_name'.i18n(),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgs/ecopoint.svg'),
                          const SizedBox(width: 4),
                          Text('reward_main_unlogin_caption'.i18n(),
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                    screen: const LoginScreen(), withNavBar: false),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'login_login_button_caption'.i18n(),
                      style: GoogleFonts.plusJakartaSans(
                        color: EcoSenseTheme.darkGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            if (AuthService.isLoggedIn()) ...[
              Row(
                children: [
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName ??
                            'User',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgs/ecopoint.svg'),
                          Text(
                              ' ${NumberFormat.decimalPattern('id-id').format(totalPoints)} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: const Color(0xFFD5F299))),
                          Text(' Eco Points',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _headerAction(
                context,
                'reward_main_myreward_button'.i18n(),
                'ticket.svg',
                () => PersistentNavBarNavigator.pushNewScreen(context,
                    screen: const MyEcoReward(), withNavBar: false),
              ),
            ]
            // _headerAction(
            //     context, 'My EcoPoints History', 'history.svg', () {}),
          ],
        ),
      ),
    );
  }
}
