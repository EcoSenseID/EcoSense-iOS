import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/my_reward_detail.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/reward/reward.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/theme.dart';
import '../reward_detail/components/amount_card.dart';
import '../reward_detail/components/how_to_use.dart';
import '../reward_detail/components/reward_description.dart';
import '../reward_detail/components/reward_terms.dart';
import '../reward_detail/components/valid_until.dart';

class MyEcoRewardDetail extends StatefulWidget {
  const MyEcoRewardDetail(this.claimId, this.title, {super.key});
  final int claimId;
  final String title;

  @override
  State<MyEcoRewardDetail> createState() => _MyEcoRewardDetailState();
}

class _MyEcoRewardDetailState extends State<MyEcoRewardDetail> {
  late Future<MyRewardDetailModel> _rewardFuture;

  @override
  void initState() {
    _rewardFuture = RewardService.myRewardDetail(widget.claimId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<MyRewardDetailModel>(
        future: _rewardFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final reward = snapshot.data!;
            return Scaffold(
              body: ListView(
                children: [
                  CachedNetworkImage(
                    imageUrl: reward.bannerUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: EcoSenseTheme.grey,
                          spreadRadius: 4,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AmountCard(reward.title, reward.partner),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValidUntil(reward.validity),
                              RewardDescription(reward.description),
                              RewardTerms(reward.termsCondition),
                              HowToUse(reward.howToUse),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [EcoSenseTheme.boxShadow],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 40),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: reward.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      reward.status,
                      style: EcoSenseTheme.calloutTextStyle
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
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
