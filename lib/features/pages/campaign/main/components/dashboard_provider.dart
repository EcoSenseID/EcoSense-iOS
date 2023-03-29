import 'package:ecosense/services/campaign/campaign_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider =
    StateProvider((ref) => CampaignService.getDashboard());
