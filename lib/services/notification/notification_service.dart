import 'package:dio/dio.dart';
import 'package:ecosense/data/models/notification.dart';
import 'package:ecosense/services/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<NotificationsModel> getNotification(String locale) async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.get(
      '/notifications',
      queryParameters: {
        'language': locale,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    final data = response.data!;
    if (!data['error']) {
      return NotificationsModel.fromJson(data);
    }
    throw ErrorDescription(data['message']);
  }
}
