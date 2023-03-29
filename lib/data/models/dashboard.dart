import 'package:ecosense/data/models/category.dart';
import 'package:intl/intl.dart';

class DashboardModel {
  final List<CampaignDashboardModel> campaigns;
  final List<CategoryModel> categories;

  DashboardModel.fromJson(Map<String, dynamic> json)
      : campaigns = (json['campaigns'] as List)
            .map((e) => CampaignDashboardModel.fromJson(e))
            .toList(),
        categories = (json['categories'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
}

class CampaignDashboardModel {
  final int id;
  // final int recordId;
  final String name;
  final DateTime endDate;
  final int completionStatus;
  final int missionLeft;
  final int missionCompleted;
  final List<MissionDashboardModel> uncompletedMissions;

  int get daysLeft => endDate.difference(DateTime.now()).inDays;

  String get until {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(endDate);
  }

  CampaignDashboardModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        // recordId = json['recordId'],
        name = json['name'],
        endDate = DateTime.fromMillisecondsSinceEpoch(json['endDate'] * 1000),
        completionStatus = json['completionStatus'],
        missionLeft = json['missionLeft'],
        missionCompleted = json['missionCompleted'],
        uncompletedMissions = (json['uncompletedMissions'] as List)
            .map((mission) => MissionDashboardModel.fromJson(mission))
            .toList();
}

class MissionDashboardModel {
  final int id;
  final String name;
  final int completionStatus;

  MissionDashboardModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        completionStatus = json['completionStatus'];
}
