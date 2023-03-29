import 'package:ecosense/features/pages/eco_reward/main/components/loaded_ecoreward.dart';
import 'package:flutter/material.dart';

class EcoRewardScreen extends StatefulWidget {
  const EcoRewardScreen({super.key});

  @override
  State<EcoRewardScreen> createState() => _EcoRewardScreenState();
}

class _EcoRewardScreenState extends State<EcoRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF036C5C),
        toolbarHeight: 0,
      ),
      body: const LoadedEcoReward(),
    );
  }
}
