import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/features/pages/profile/main/components/recent_story.dart';
import 'package:ecosense/features/pages/profile/story_history.dart/story_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyPost extends StatelessWidget {
  const MyPost(this.stories, this.withHeader, {this.userId, super.key});
  final int? userId;
  final bool withHeader;
  final List<StoryModel> stories;

  Widget _noPost(BuildContext context) => Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Image.asset(
            'assets/images/Character-06.png',
            width: 110,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'profile_nohistory_caption'.i18n(),
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withHeader)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Text(
                  userId == null
                      ? 'profile_mypost_section_title'.i18n()
                      : 'other_main_post_section_title'.i18n(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.black),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: StoryHistoryScreen(userId: userId)),
                    child: Text(
                      'profile_see_all_button'.i18n(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: EcoSenseTheme.darkGreen,
                      ),
                    )),
              ],
            ),
          ),
        stories.isEmpty
            ? _noPost(context)
            : Column(
                children: stories.map((story) => RecentStory(story)).toList(),
              ),
      ],
    );
  }
}
