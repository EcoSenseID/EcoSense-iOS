class RewardDetail {
  final int id;
  final String bannerUrl;
  final String title;
  final String partner;
  final int pointsNeeded;
  final DateTime validity;
  final String description;
  final List<String> termsCondition;
  final List<String> howToUse;
  final int maxRedeem;
  final int numberOfRedeem;
  final String category;

  RewardDetail.fromJson(this.id, Map<String, dynamic> json)
      : bannerUrl = json['bannerUrl'],
        title = json['title'],
        partner = json['partner'],
        pointsNeeded = json['pointsNeeded'],
        validity = DateTime.fromMillisecondsSinceEpoch(json['validity'] * 1000),
        description = json['description'],
        termsCondition = List<String>.from(json['termsCondition']),
        howToUse = List<String>.from(json['howToUse']),
        maxRedeem = json['maxRedeem'],
        numberOfRedeem = json['numberOfRedeem'],
        category = json['category'];
}
