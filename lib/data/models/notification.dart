import 'package:ecosense/features/pages/campaign/detail/campaign_detail.dart';
import 'package:ecosense/features/pages/eco_reward/my_ecoreward_detail/my_ecoreward_detail.dart';
import 'package:ecosense/features/pages/eco_world/main/components/eco_world_coming.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class NotificationsModel {
  final List<NotificationModel> notifications;

  List<NotificationModel> get todayNotifications => notifications
      .where((notification) => notification.timestamp
          .isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<NotificationModel> get yesterdayNotifications => notifications
      .where((notification) =>
          notification.timestamp
              .isAfter(DateTime.now().subtract(const Duration(days: 2))) &&
          notification.timestamp
              .isBefore(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<NotificationModel> get lastWeekNotifications => notifications
      .where((notification) =>
          notification.timestamp
              .isAfter(DateTime.now().subtract(const Duration(days: 7))) &&
          notification.timestamp
              .isBefore(DateTime.now().subtract(const Duration(days: 2))))
      .toList();

  List<NotificationModel> get olderNotifications => notifications
      .where((notification) => notification.timestamp
          .isBefore(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  NotificationsModel.fromJson(Map<String, dynamic> json)
      : notifications = (json['notifications'] as List<dynamic>)
            .map((dynamic e) =>
                NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList();
}

class NotificationModel {
  final int id;
  final DateTime timestamp;
  final String content;
  final String? iconUrl;
  final String deeplink;

  Widget get redirectPage {
    Uri uri = Uri.parse(deeplink);
    final segments = uri.pathSegments;
    final page = segments[1];
    final id = segments[2];
    switch (page) {
      case 'campaigndetail':
        return CampaignDetailScreen(int.parse(id));
      case 'rewarddetail':
        return MyEcoRewardDetail(int.parse(id), 'reward_detail'.i18n());
    }
    return Scaffold(
      appBar: AppBar(),
      body: const EcoWorldComingSoon(),
    );
  }

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        timestamp =
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
        content = json['content'],
        iconUrl = json['iconUrl'],
        deeplink = json['deeplink'];
}
