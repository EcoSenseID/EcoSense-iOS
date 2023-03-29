// class CampaignPreviewModel {
//   final int id;
//   final String posterUrl;
//   final String title;
//   final DateTime endDate;
//   final List<String> category;
//   final int participantsCount;
//   final bool isTrending;
//   final bool isNew;

//   Campaign.fromJson(Map<String, dynamic> data)
//       : id = data['id'],
//         posterUrl = data['posterUrl'],
//         title = data['title'],
//         endDate = DateTime.fromMillisecondsSinceEpoch(
//             int.parse(data['endDate']) * 1000),
//         category = List<String>.from(data['category']),
//         participantsCount = data['participantsCount'],
//         isTrending = data['isTrending'],
//         isNew = data['isNew'];
// }
