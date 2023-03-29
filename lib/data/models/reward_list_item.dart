class RewardListItem {
  final int id;
  final String bannerUrl;
  final String title;
  final String partner;
  final String category;
  final int pointsNeeded;
  final int maxRedeem;
  final int numberOfRedeem;

  RewardListItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        bannerUrl = json['bannerUrl'],
        title = json['title'],
        partner = json['partner'],
        pointsNeeded = json['pointsNeeded'],
        maxRedeem = json['maxRedeem'],
        numberOfRedeem = json['numberOfRedeem'],
        category = json['category'];
}
