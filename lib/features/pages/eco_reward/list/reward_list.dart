import 'package:ecosense/data/models/reward_list_item.dart';
import 'package:ecosense/features/pages/eco_reward/list/components/list_item.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/reward/reward.dart';
import 'package:flutter/material.dart';

class RewardListScreen extends StatefulWidget {
  const RewardListScreen(this.categoryId, this.categoryName, this.currentPoint,
      {super.key});
  final int categoryId;
  final String categoryName;
  final int currentPoint;

  @override
  State<RewardListScreen> createState() => _RewardListScreenState();
}

class _RewardListScreenState extends State<RewardListScreen> {
  late Future<List<RewardListItem>> _rewardsFuture;

  @override
  void initState() {
    _rewardsFuture = RewardService.rewardList(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder<List<RewardListItem>>(
        future: _rewardsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final rewards = snapshot.data!;
            return ListView.builder(
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                return RewardItemWidget(rewards[index], widget.currentPoint);
              },
            );
          }
          if (snapshot.hasError) {
            return const SomethingWentWrong();
          }
          return const Loading();
        },
      ),
    );
  }
}
