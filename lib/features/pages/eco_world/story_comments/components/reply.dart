import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/story_replies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../services/auth/auth_service.dart';
import '../../../../../services/story/story.dart';
import '../../../../widgets/images.dart';
import '../../../../widgets/toast.dart';
import '../../../profile/others_profile/others_profile.dart';

class ReplyWidget extends StatefulWidget {
  const ReplyWidget(this.reply, {super.key});
  final StoryReply reply;

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  late bool _isSupported;
  late int _supporterCount;

  Color get _supportColor =>
      _isSupported ? EcoSenseTheme.electricGreen : EcoSenseTheme.superDarkGray;

  @override
  void initState() {
    _isSupported = widget.reply.isSupported;
    _supporterCount = widget.reply.supportersCount;
    super.initState();
  }

  void _toggleSupport() async {
    if (!AuthService.isLoggedIn()) {
      Toasts.showFailedToast('must_log_in'.i18n(), context);
      return;
    }
    if (_isSupported) {
      await StoryService.unsupportReply(widget.reply.id);
      _supporterCount--;
    } else {
      await StoryService.supportReply(widget.reply.id);
      _supporterCount++;
    }
    setState(() => _isSupported = !_isSupported);
  }

  void _goToProfile(int userId) =>
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: OthersProfile(userId));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () => _goToProfile(widget.reply.userId),
              child: Images.circle(widget.reply.avatarUrl, radius: 20)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => _goToProfile(widget.reply.userId),
                    child: Text(
                      widget.reply.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: EcoSenseTheme.darkGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: Colors.grey[700],
                    radius: 2,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.reply.formattedDate,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: EcoSenseTheme.superDarkGray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                widget.reply.caption,
                style: GoogleFonts.plusJakartaSans(fontSize: 14),
              ),
              const SizedBox(height: 2),
              if (widget.reply.attachedPhotoUrl != "") ...[
                const SizedBox(height: 2),
                const SizedBox(height: 2),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.reply.attachedPhotoUrl,
                    width: 230,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 2),
              ],
              InkWell(
                onTap: _toggleSupport,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/like.svg',
                      color: _supportColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$_supporterCount',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _supportColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// class ReplyWidget extends ConsumerWidget {
//   const ReplyWidget(this.reply, {super.key});
//   final StoryReply reply;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//       child: Row(
//         children: [
//           Images.circle(reply.avatarUrl, radius: 20),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     reply.name,
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: EcoSenseTheme.darkGreen,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   CircleAvatar(
//                     backgroundColor: Colors.grey[700],
//                     radius: 2,
//                   ),
//                   const SizedBox(width: 5),
//                   Text(
//                     reply.formattedDate,
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 12,
//                       color: EcoSenseTheme.superDarkGray,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 reply.caption,
//                 style: GoogleFonts.plusJakartaSans(fontSize: 14),
//               ),
//               const SizedBox(height: 2),
//               if (reply.attachedPhotoUrl != "") ...[
//                 const SizedBox(height: 2),
//                 SizedBox(height: 2),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: CachedNetworkImage(
//                     imageUrl: reply.attachedPhotoUrl,
//                     width: 230,
//                     height: 130,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(height: 2),
//               ],
//               Row(
//                 children: [
//                   SvgPicture.asset('assets/svgs/like.svg'),
//                   const SizedBox(width: 5),
//                   Text(
//                     '${reply.supportersCount}',
//                     style: GoogleFonts.plusJakartaSans(
//                         fontSize: 10, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
