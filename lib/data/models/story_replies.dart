import 'package:intl/intl.dart';

class StoryReply {
  final int id;
  final int userId;
  final String name;
  final String avatarUrl;
  final String caption;
  final String attachedPhotoUrl;
  final DateTime createdAt;
  final int supportersCount;
  final bool isSupported;

  String get formattedDate {
    return DateFormat('dd MMM yy - HH:mm').format(createdAt);
  }

  StoryReply.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        name = json['name'],
        avatarUrl = json['avatarUrl'],
        caption = json['caption'],
        attachedPhotoUrl = json['attachedPhotoUrl'],
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
        supportersCount = json['supportersCount'],
        isSupported = json['isSupported'];
}
