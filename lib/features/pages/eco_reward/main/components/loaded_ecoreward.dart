import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/reward_homepage.dart';
import 'package:ecosense/features/pages/eco_reward/main/components/horizontal_donations.dart';
import 'package:ecosense/features/pages/eco_reward/main/components/horizontal_ewallet.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/reward/reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import 'reward_header.dart';

class LoadedEcoReward extends ConsumerStatefulWidget {
  const LoadedEcoReward({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoadedEcoRewardState();
}

class _LoadedEcoRewardState extends ConsumerState<LoadedEcoReward> {
  late Future<RewardHomepage> _homeFuture;

  @override
  void initState() {
    _homeFuture = RewardService.rewardHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RewardHomepage>(
      future: _homeFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final homePage = snapshot.data!;
          return ListView(
            children: [
              RewardHeader(homePage.totalPoints),
              const SizedBox(height: 24),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'get_benefit'.i18n(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: EcoSenseTheme.darkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              HorizontalDonation(
                  homePage.donationRewards, homePage.totalPoints),
              HorizontalEwallet(homePage.walletRewards, homePage.totalPoints),
            ],
          );
        }
        if (snapshot.hasError) return const SomethingWentWrong();
        return const Loading();
      },
    );
  }
}
