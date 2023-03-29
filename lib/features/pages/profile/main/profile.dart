import 'package:ecosense/data/models/profile.dart';
import 'package:ecosense/features/pages/profile/main/components/campaign_history.dart';
import 'package:ecosense/features/pages/profile/main/components/profile_actions.dart';
import 'package:ecosense/features/pages/profile/main/components/profile_detail.dart';
import 'package:ecosense/features/pages/profile/settings/profile_settings.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/login_first.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:ecosense/services/profile/profile_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppBar _appBar(BuildContext context) => AppBar(
        title: Text('profile_title'.i18n()),
        actions: [
          if (AuthService.isLoggedIn())
            IconButton(
              onPressed: (() => PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const SettingsScreen())),
              icon: const Icon(Icons.more_vert),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: !AuthService.isLoggedIn()
          ? const LoginFirst()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView(
                children: [
                  const SizedBox(height: 28),
                  const ProfileDetailVertical(),
                  const SizedBox(height: 24),
                  FutureBuilder<ProfileModel>(
                    future: ProfileDetailService.profileDetail(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final profileDetail = snapshot.data!;
                        return Column(
                          children: [
                            ProfileActions(profileDetail.totalEcoPoints),
                            // const SizedBox(height: 20),
                            // MyPost(profileDetail.recentStories, true),
                            const SizedBox(height: 24),
                            CampaignHistory(profileDetail.recentCampaigns),
                          ],
                        );
                      }
                      if (snapshot.hasError) return const SomethingWentWrong();
                      return const Loading();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
