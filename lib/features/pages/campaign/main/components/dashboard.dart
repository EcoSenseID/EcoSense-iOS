import 'package:ecosense/data/models/dashboard.dart';
import 'package:ecosense/features/pages/campaign/main/components/dashboard_campaigns.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';

import 'dashboard_provider.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardFuture = ref.watch(dashboardProvider);
    return Scaffold(
      appBar: AppBar(title: Text('campaign_main_title'.i18n())),
      body: FutureBuilder<DashboardModel>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: [
                DashboardCampaigns(data.campaigns),
              ],
            );
          }
          if (snapshot.hasError) return const SomethingWentWrong();
          return const Loading();
        },
      ),
    );
  }
}
