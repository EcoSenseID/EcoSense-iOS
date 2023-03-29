import 'package:ecosense/data/models/others_profile.dart';
import 'package:ecosense/features/pages/profile/main/components/campaign_history.dart';
import 'package:ecosense/features/pages/profile/main/components/my_post.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/profile/profile_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../widgets/gradient_text.dart';
import '../../../widgets/images.dart';

class OthersProfile extends StatefulWidget {
  const OthersProfile(this.userId, {super.key});
  final int userId;

  @override
  State<OthersProfile> createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile> {
  late Future<OthersProfileModel> _profileFuture;

  @override
  void initState() {
    _profileFuture = ProfileDetailService.getOthersProfile(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('navBar_profile_button'.i18n())),
      body: FutureBuilder<OthersProfileModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ListView(
                children: [
                  const SizedBox(height: 28),
                  Images.circle(user.avatarUrl, radius: 38),
                  const SizedBox(height: 10),
                  Center(child: GradientText(user.name)),
                  const SizedBox(height: 30),
                  MyPost(user.recentStories, true, userId: widget.userId),
                  const SizedBox(height: 24),
                  CampaignHistory(user.recentCampaigns, userId: widget.userId),
                ],
              ),
            );
          }
          if (snapshot.hasError) return const SomethingWentWrong();
          return const Loading();
        },
      ),
    );
  }
}
