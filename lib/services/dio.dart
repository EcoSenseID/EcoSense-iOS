import 'package:dio/dio.dart';

var dio = Dio(
  BaseOptions(
    baseUrl: 'https://ecosense-bangkit.uc.r.appspot.com',
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);
