// ignore_for_file: use_build_context_synchronously

import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/auth/login.dart';
import 'package:ecosense/features/pages/campaign/detail/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/main/components/dashboard_provider.dart';
import 'package:ecosense/features/widgets/gradient_button.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/campaign/campaign_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';
import '../../../auth/components/auth_theme.dart';

class JoinCampaignBar extends ConsumerStatefulWidget {
  const JoinCampaignBar(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JoinCampaignBarState();
}

class _JoinCampaignBarState extends ConsumerState<JoinCampaignBar> {
  String buttonText = 'campaign_campaign_detail_join_button'.i18n();

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      buttonText = 'login_login_button_caption'.i18n();
    }
    super.initState();
  }

  void _joinPressed(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser == null) {
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: const LoginScreen(), withNavBar: false);
      return;
    }
    setState(() {
      buttonText = 'Joining...';
    });
    final response = await CampaignService.joinCampaign(widget.campaign.id);
    if (response) {
      Toasts.showSuccessToast('Campaign Joined!', context);
      Navigator.of(context).pop();
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: CampaignDetailScreen(widget.campaign.id));
      ref.read(dashboardProvider.notifier).state =
          CampaignService.getDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: EcoSenseTheme.darkGrey,
            spreadRadius: 2,
            blurRadius: 7,
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DateTime.now().isBefore(widget.campaign.startDate)
                ? Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: EcoSenseTheme.darkerGrey,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'coming_soon'.i18n(),
                        textAlign: TextAlign.center,
                        style: AuthTheme.buttonTextTheme
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                : widget.campaign.isOpen
                    ? GradientButton(
                        text: buttonText, handler: () => _joinPressed(context))
                    : Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: EcoSenseTheme.darkerGrey,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'profile_campaign_detail_status_end'.i18n(),
                            textAlign: TextAlign.center,
                            style: AuthTheme.buttonTextTheme
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}

// class JoinCampaignBar extends StatefulWidget {
//   const JoinCampaignBar(this.campaign, {super.key});
//   final CampaignDetailModel campaign;

//   @override
//   State<JoinCampaignBar> createState() => _JoinCampaignBarState();
// }

// class _JoinCampaignBarState extends State<JoinCampaignBar> {
//   String buttonText = 'Join this campaign';

//   void _joinPressed(BuildContext context) async {
//     print('pressed');
//     setState(() {
//       buttonText = 'Joining...';
//     });
//     final response = await CampaignService.joinCampaign(widget.campaign.id);
//     if (response) {
//       Toasts.showSuccessToast('Campaign Joined!', context);
//       Navigator.of(context).pop();
//       PersistentNavBarNavigator.pushNewScreen(context,
//           screen: CampaignDetailScreen(widget.campaign.id));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(32),
//           topRight: Radius.circular(32),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: EcoSenseTheme.darkGrey,
//             spreadRadius: 2,
//             blurRadius: 7,
//           ),
//         ],
//       ),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxHeight: 40),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: widget.campaign.isOpen
//                 ? GradientButton(
//                     text: buttonText, handler: () => _joinPressed(context))
//                 : Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: EcoSenseTheme.darkGrey,
//                       borderRadius: BorderRadius.circular(70),
//                     ),
//                     width: double.infinity,
//                     child: Center(
//                       child: Text(
//                         'Campaign ended',
//                         textAlign: TextAlign.center,
//                         style: AuthTheme.buttonTextTheme
//                             .copyWith(color: Colors.white),
//                       ),
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
