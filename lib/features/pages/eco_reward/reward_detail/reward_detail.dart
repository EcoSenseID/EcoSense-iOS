import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/reward_detail.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/amount_card.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/how_to_use.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/redeem_button.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/reward_description.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/reward_terms.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/valid_until.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/theme.dart';
import '../../../../services/reward/reward.dart';
import '../../../widgets/something_went_wrong.dart';

class RewardDetailScreen extends ConsumerStatefulWidget {
  const RewardDetailScreen(this.rewardId, this.rewardTitle, this.currentPoint,
      {super.key});
  final int rewardId;
  final String rewardTitle;
  final int currentPoint;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardDetailScreenState();
}

class _RewardDetailScreenState extends ConsumerState<RewardDetailScreen> {
  late Future<RewardDetail> _rewardDetail;

  @override
  void initState() {
    _rewardDetail = RewardService.rewardDetail(widget.rewardId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rewardTitle),
      ),
      body: FutureBuilder<RewardDetail>(
        future: _rewardDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final reward = snapshot.data!;
            return Scaffold(
                body: SafeArea(
                  child: ListView(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                ),
                bottomNavigationBar: RedeemButton(reward, widget.currentPoint));
          }
          if (snapshot.hasError) return const SomethingWentWrong();
          return const Loading();
        },
      ),
    );
  }
}
