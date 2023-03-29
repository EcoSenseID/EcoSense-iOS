class Supporter {
  final int userId;
  final String avatarUrl;
  final String name;

  Supporter.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        avatarUrl = json['avatarUrl'],
        name = json['name'];
}
