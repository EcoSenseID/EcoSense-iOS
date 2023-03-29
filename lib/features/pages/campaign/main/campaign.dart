import 'package:ecosense/features/pages/campaign/main/components/categories.dart';
import 'package:ecosense/features/pages/campaign/main/components/dashboard.dart';
import 'package:ecosense/features/pages/campaign/main/components/not_logged_in_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const Dashboard();
    }
    return Scaffold(
      appBar: AppBar(title: Text('campaign_main_title'.i18n())),
      body: ListView(
        children: const [
          NotLoggedInDashboard(),
          Categories(),
        ],
      ),
    );
  }
}
