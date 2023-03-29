import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/features/pages/eco_world/main/components/campaign_preview.dart';
import 'package:ecosense/features/pages/eco_world/story_comments/story_comments.dart';
import 'package:ecosense/features/pages/eco_world/supporters/supporters_screen.dart';
import 'package:ecosense/features/pages/profile/others_profile/others_profile.dart';
import 'package:ecosense/features/widgets/images.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:ecosense/services/story/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:share_plus/share_plus.dart';

class StoryPreview extends StatefulWidget {
  const StoryPreview(this.story, {super.key});
  final StoryModel story;

  @override
  State<StoryPreview> createState() => _StoryPreviewState();
}

class _StoryPreviewState extends State<StoryPreview> {
  late bool _isSupported;
  late int _supporterCount;

  Color get _supportColor =>
      _isSupported ? EcoSenseTheme.electricGreen : EcoSenseTheme.superDarkGray;

  @override
  void initState() {
    _isSupported = widget.story.isSupported;
    _supporterCount = widget.story.supportersCount;
    super.initState();
  }

  void _toggleSupport() async {
    if (!AuthService.isLoggedIn()) {
      Toasts.showFailedToast('must_log_in'.i18n(), context);
      return;
    }
    if (_isSupported) {
      await StoryService.unsupportStory(widget.story.id);
      _supporterCount--;
    } else {
      await StoryService.supportStory(widget.story.id);
      _supporterCount++;
    }
    setState(() => _isSupported = !_isSupported);
  }

  Widget _supporterAvatars(BuildContext context) => GestureDetector(
        onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
            screen: SupporterScreen(widget.story.id)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 16, maxWidth: 35),
              child: Stack(
                children: [
                  for (var i = 0;
                      i < widget.story.supportersAvatarsUrl.length;
                      i++)
                    Positioned(
                      left: i * 8.0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundImage: CachedNetworkImageProvider(
                          widget.story.supportersAvatarsUrl[i],
                        ),
                      ),
                    ),
                ],
                // children: story.supportersAvatarsUrl
                //     .map((url) => Images.circle(url, radius: 8))
                //     .toList(),
              ),
            ),
          ],
        ),
      );

  void _commentPressed(BuildContext context) =>
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: StoryCommentsScreen(widget.story), withNavBar: false);

  void _sharePressed() => Share.share(
      '${'check_this_out'.i18n()} https://ecosense.id/deeplink/storydetail/${widget.story.id}');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                      screen: OthersProfile(widget.story.userId),
                      withNavBar: false),
                  child: Images.circle(widget.story.avatarUrl, radius: 23)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: OthersProfile(widget.story.userId),
                            withNavBar: false),
                        child: Text(
                          widget.story.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: EcoSenseTheme.darkGreen,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 5),
                      CircleAvatar(
                          backgroundColor: Colors.grey[700], radius: 2),
                      const SizedBox(width: 5),
                      Text(
                        widget.story.formattedDate,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: EcoSenseTheme.superDarkGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 120),
                    child: Text(
                      widget.story.caption,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  if (widget.story.attachedPhotoUrl != "") ...[
                    const SizedBox(height: 4),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 120),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                              imageUrl: widget.story.attachedPhotoUrl)),
                    ),
                  ],
                  if (widget.story.sharedCampaign != null)
                    CampaignPreview(widget.story.sharedCampaign!),
                  const SizedBox(height: 8),
                  if (widget.story.supportersCount > 0) ...[
                    _supporterAvatars(context),
                    const SizedBox(height: 12),
                  ],
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 32, maxWidth: 250),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: _toggleSupport,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/like.svg',
                                color: _supportColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$_supporterCount',
                                style: TextStyle(color: _supportColor),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _commentPressed(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svgs/comment.svg'),
                                const SizedBox(width: 4),
                                Text('${widget.story.repliesCount}',
                                    style: const TextStyle(
                                        color: EcoSenseTheme.superDarkGray)),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _sharePressed,
                          child: SvgPicture.asset('assets/svgs/share.svg'),
                        ),
                        const SizedBox(width: 4),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 2, color: EcoSenseTheme.grey),
      ],
    );
  }
}
