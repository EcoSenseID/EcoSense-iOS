import 'package:ecosense/extensions/hex_color.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String photoUrl;
  final String name;
  final String colorHex;

  Color get color => HexColor.fromHex(colorHex);

  LinearGradient get verticalGradient => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          color,
          const Color(0x00000000),
        ],
        stops: const [0, 0.5],
      );

  LinearGradient get horizontalGradient => LinearGradient(
        colors: [
          color,
          const Color(0x00000000),
        ],
      );

  CategoryModel.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        photoUrl = data['photoUrl'],
        name = data['name'],
        colorHex = data['colorHex'];
}
