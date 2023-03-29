import 'package:ecosense/data/models/my_reward_preview.dart';
import 'package:ecosense/features/pages/eco_reward/my_ecoreward/components/myreward_card.dart';
import 'package:ecosense/services/reward/reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class MyEcoReward extends ConsumerStatefulWidget {
  const MyEcoReward({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyEcoRewardState();
}

class _MyEcoRewardState extends ConsumerState<MyEcoReward> {
  late Future<List<MyRewardPreview>> _myRewardsFuture;

  @override
  void initState() {
    _myRewardsFuture = RewardService.myRewards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reward_myreward_title'.i18n()),
      ),
      body: FutureBuilder<List<MyRewardPreview>>(
        future: _myRewardsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final myRewards = snapshot.data!;
            if (myRewards.isNotEmpty) {
              return ListView.builder(
                itemCount: myRewards.length,
                itemBuilder: (context, index) {
                  final myReward = myRewards[index];
                  return MyRewardCard(myReward);
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/Character-04.png',
                      width: 180,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'reward_history_nouse_caption1'.i18n(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'reward_history_nouse_caption2'.i18n(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          if (snapshot.hasError) return Text('went_wrong'.i18n());
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
