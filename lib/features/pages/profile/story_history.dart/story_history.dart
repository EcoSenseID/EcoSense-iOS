import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/features/pages/profile/main/components/my_post.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/profile/profile_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class StoryHistoryScreen extends StatefulWidget {
  const StoryHistoryScreen({this.userId, super.key});
  final int? userId;

  @override
  State<StoryHistoryScreen> createState() => _StoryHistoryScreenState();
}

class _StoryHistoryScreenState extends State<StoryHistoryScreen> {
  late Future<List<StoryModel>> _storiesFuture;

  @override
  void initState() {
    _storiesFuture = ProfileDetailService.getRecentPost(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.userId == null
              ? 'profile_mypost_section_title'.i18n()
              : 'other_main_post_section_title'.i18n())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: FutureBuilder<List<StoryModel>>(
          future: _storiesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(children: [MyPost(snapshot.data!, false)]);
            }
            if (snapshot.hasError) return const SomethingWentWrong();
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
