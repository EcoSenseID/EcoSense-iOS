import 'package:ecosense/data/models/story_replies.dart';
import 'package:ecosense/features/pages/eco_world/story_comments/components/comment_field.dart';
import 'package:ecosense/features/pages/eco_world/story_comments/components/main_story.dart';
import 'package:ecosense/features/pages/eco_world/story_comments/components/reply.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/story/story.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/story.dart';

class StoryCommentsScreen extends StatefulWidget {
  const StoryCommentsScreen(this.story, {super.key});
  final StoryModel story;

  @override
  State<StoryCommentsScreen> createState() => _StoryCommentsScreenState();
}

class _StoryCommentsScreenState extends State<StoryCommentsScreen> {
  late Future<List<StoryReply>> _replies;

  @override
  void initState() {
    _replies = StoryService.getReplies(widget.story.id);
    super.initState();
  }

  void _refresh() {
    setState(() {
      _replies = StoryService.getReplies(widget.story.id);
    });
  }

  // Widget _supporterAvatars(BuildContext context) => GestureDetector(
  //       onTap: () => _showSupporters(context),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           ConstrainedBox(
  //             constraints: const BoxConstraints(maxHeight: 16, maxWidth: 35),
  //             child: Stack(
  //               children: [
  //                 for (var i = 0;
  //                     i < widget.story.supportersAvatarsUrl.length;
  //                     i++)
  //                   Positioned(
  //                     left: i * 8.0,
  //                     child: CircleAvatar(
  //                       radius: 8,
  //                       backgroundImage: CachedNetworkImageProvider(
  //                         widget.story.supportersAvatarsUrl[i],
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //               // children: story.supportersAvatarsUrl
  //               //     .map((url) => Images.circle(url, radius: 8))
  //               //     .toList(),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  // void _showSupporters(BuildContext context) =>
  //     SupportedModal.showSupporters(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoWorld')),
      body: Stack(
        children: [
          ListView(
            children: [
              MainStory(widget.story),
              FutureBuilder<List<StoryReply>>(
                future: _replies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final replies = snapshot.data!;
                    return Column(
                      children:
                          replies.map((reply) => ReplyWidget(reply)).toList(),
                    );
                  }
                  if (snapshot.hasError) return const SomethingWentWrong();
                  return const Loading();
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: CommentField(widget.story.id, _refresh),
          ),
        ],
      ),
    );
  }
}
