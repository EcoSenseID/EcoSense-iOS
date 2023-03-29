import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/core/routes/routes.dart';
import 'package:ecosense/features/pages/campaign/main/campaign.dart';
import 'package:ecosense/features/pages/eco_reward/main/eco_reward.dart';
import 'package:ecosense/features/pages/eco_world/main/eco_world.dart';
import 'package:ecosense/features/pages/home/tab_provider.dart';
import 'package:ecosense/features/pages/notifications/notifications.dart';
import 'package:ecosense/features/pages/profile/main/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables
  Home({super.key});

  PersistentBottomNavBarItem _navBarItem(String title, String fileName) =>
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/svgs/$fileName',
          color: EcoSenseTheme.darkGreen,
          fit: BoxFit.none,
          clipBehavior: Clip.none,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/svgs/$fileName',
          color: EcoSenseTheme.superDarkGray,
          fit: BoxFit.none,
          clipBehavior: Clip.none,
        ),
        title: title,
        // textStyle: EcoSenseTheme.tabBarTextTheme,
        activeColorPrimary: Colors.white,
        activeColorSecondary: EcoSenseTheme.darkGreen,
        inactiveColorPrimary: EcoSenseTheme.superDarkGray,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          routes: Routes.routes,
        ),
      );

  List<Widget> _buildScreens() => [
        const CampaignScreen(),
        const EcoWorldScreen(),
        const EcoRewardScreen(),
        const NotificationScreen(),
        const ProfileScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarItems() => [
        _navBarItem('navBar_campaign_button'.i18n(), 'campaign.svg'),
        _navBarItem('EcoWorld', 'ecoworld.svg'),
        _navBarItem('EcoReward', 'ecoreward.svg'),
        _navBarItem('navBar_notification_button'.i18n(), 'bell.svg'),
        _navBarItem('navBar_profile_button'.i18n(), 'profile.svg'),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = ref.watch(tabProvider);

    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     // Phoenix.rebirth(context);
    //     Navigator.of(context).popUntil((route) => route.isFirst);
    //     Navigator.of(context).popAndPushNamed(Routes.login);
    //   }
    // });

    return PersistentTabView(
      context,
      controller: tabController,
      screens: _buildScreens(),
      items: _navBarItems(),
      navBarStyle: NavBarStyle.style3,
      navBarHeight: 64,
      padding: const NavBarPadding.only(top: 16),
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      stateManagement: false,
      // screenTransitionAnimation: ScreenTransitionAnimation(
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
    );
  }
}
