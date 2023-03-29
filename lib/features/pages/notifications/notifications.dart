import 'dart:io';

import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/notification.dart';
import 'package:ecosense/features/widgets/images.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/login_first.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:ecosense/services/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<NotificationsModel> _notificationList;

  @override
  void initState() {
    final locale = Platform.localeName;
    String notifLocale = 'en';
    if (locale.contains('id')) {
      notifLocale = 'id';
    }
    _notificationList = NotificationService.getNotification(notifLocale);
    super.initState();
  }

  Widget _buildNotificationList(BuildContext context, String header,
          List<NotificationModel> notifications) =>
      notifications.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(header,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: EcoSenseTheme.darkGreen)),
                  ...notifications
                      .map(
                        (notification) => Column(
                          children: [
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: notification.redirectPage,
                                    withNavBar: false);
                                // launchUrl(Uri.parse(notification.deeplink));
                              },
                              child: Row(
                                children: [
                                  Images.circle(notification.iconUrl,
                                      radius: 23),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                130),
                                        child: Text(
                                          notification.content,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat('d MMMM yyyy - HH:mm')
                                            .format(notification.timestamp),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color:
                                                    EcoSenseTheme.superDarkGray,
                                                fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('navBar_notification_button'.i18n())),
      body: !AuthService.isLoggedIn()
          ? const LoginFirst()
          : FutureBuilder<NotificationsModel>(
              future: _notificationList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final notifications = snapshot.data!;
                  return ListView(
                    children: [
                      _buildNotificationList(
                          context,
                          'notificaiton_main_today_section_title'.i18n(),
                          notifications.todayNotifications),
                      _buildNotificationList(
                          context,
                          'notificaiton_main_yesterday_section_title'.i18n(),
                          notifications.yesterdayNotifications),
                      _buildNotificationList(
                          context,
                          'notificaiton_main_lastweek_section_title'.i18n(),
                          notifications.lastWeekNotifications),
                      _buildNotificationList(
                          context,
                          'notificaiton_main_older_section_title'.i18n(),
                          notifications.olderNotifications),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const SomethingWentWrong();
                }
                if (snapshot.hasError) return const SomethingWentWrong();
                return const Loading();
              },
            ),
    );
  }
}
