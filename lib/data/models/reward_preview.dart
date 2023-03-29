class RewardPreview {
  final int id;
  final String bannerUrl;
  final String title;
  final String partner;
  final int pointsNeeded;

  RewardPreview.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        bannerUrl = json['bannerUrl'],
        title = json['title'],
        partner = json['partner'],
        pointsNeeded = json['pointsNeeded'];
}
