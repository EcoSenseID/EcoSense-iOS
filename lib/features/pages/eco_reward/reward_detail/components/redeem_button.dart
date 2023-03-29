import 'package:ecosense/data/models/reward_detail.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/donate_modal.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/not_enough_points.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/reward_form.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';
import '../../../auth/login.dart';

class RedeemButton extends StatelessWidget {
  const RedeemButton(this.reward, this.currentPoint, {super.key});
  final RewardDetail reward;
  final int currentPoint;

  void _redeemPressed(BuildContext context) {
    if (!AuthService.isLoggedIn()) {
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: const LoginScreen());
      return;
    }
    if (currentPoint < reward.pointsNeeded) {
      showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) => const NotEnoughPoint(),
      );
      return;
    }
    if (reward.category == 'donation') {
      showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) => DonateModal(reward),
      );
    }
    if (reward.category == 'e-wallet') {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        isScrollControlled: true,
        builder: (context) => RewardForm(reward),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 18,
        bottom: 40,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: EcoSenseTheme.grey,
            spreadRadius: 4,
            blurRadius: 3,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _redeemPressed(context),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: EcoSenseTheme.verticalGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: AuthService.isLoggedIn()
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Redeem',
                        style: EcoSenseTheme.calloutTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 2),
                      SvgPicture.asset('assets/svgs/ecopoint.svg'),
                      Text(
                        NumberFormat.decimalPattern('ID-id')
                            .format(reward.pointsNeeded),
                        style: EcoSenseTheme.calloutTextStyle
                            .copyWith(color: const Color(0xFFD5F299)),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Eco Points',
                        style: EcoSenseTheme.calloutTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  )
                : Text(
                    'login_login_button_caption'.i18n(),
                    style: EcoSenseTheme.calloutTextStyle
                        .copyWith(color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
