import 'dart:developer';

import 'package:ecosense/data/models/reward_detail.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/donation_sent.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/small_gradient_button.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/small_outlined_button.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/reward/reward.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DonateModal extends StatelessWidget {
  const DonateModal(this.reward, {super.key});
  final RewardDetail reward;

  void _donatePressed(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    await RewardService.redeemReward(reward.id).then((status) {
      Navigator.pop(context);
      Navigator.pop(context);
      if (status) {
        showMaterialModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          context: context,
          builder: (context) => const DonationSent(),
        );
      } else {
        Toasts.showFailedToast('went_wrong'.i18n(), context);
      }
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      Navigator.pop(context);
      log(stackTrace.toString());
      Toasts.showFailedToast('went_wrong'.i18n(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'sure_redeem'.i18n(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmallOutlinedButton(
                  'login_cancel_button'.i18n(), Navigator.of(context).pop),
              const SizedBox(width: 12),
              SmallGradientButton(
                  'reward_redeem_donation_notification_yes_button'.i18n(),
                  () => _donatePressed(context)),
            ],
          ),
        ],
      )),
    );
  }
}
