// ignore_for_file: use_build_context_synchronously

import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/widgets/images.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:ecosense/services/story/story.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../auth/login.dart';

class CommentField extends ConsumerStatefulWidget {
  const CommentField(this.storyId, this.onComment, {super.key});
  final int storyId;
  final VoidCallback onComment;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentFieldState();
}

class _CommentFieldState extends ConsumerState<CommentField> {
  bool isActive = false;
  final FocusNode _focus = FocusNode();
  late TextEditingController commentController;

  @override
  void initState() {
    commentController = TextEditingController();
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isActive = _focus.hasFocus;
    });
  }

  void _postComment() async {
    final comment = commentController.text;
    if (comment.isEmpty) {
      Toasts.showFailedToast('Comment cannot be empty!', context);
    }
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    final response = await StoryService.postReply(widget.storyId, comment, null)
        .whenComplete(() => Navigator.of(context).pop());
    if (response) {
      Toasts.showSuccessToast('Comment posted!', context);
      commentController.clear();
      _focus.unfocus();
      widget.onComment();
    } else {
      Toasts.showFailedToast('Failed to post comment!', context);
    }
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (!AuthService.isLoggedIn()) {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 24, top: 20),
        padding: const EdgeInsets.all(10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: EcoSenseTheme.darkGrey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'login_to_join'.i18n(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: EcoSenseTheme.darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: const LoginScreen(), withNavBar: false);
              },
              child: Container(
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: EcoSenseTheme.verticalGradient,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                    child: Text(
                  'login_login_button_caption'.i18n(),
                  style: EcoSenseTheme.calloutTextStyle
                      .copyWith(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 24, top: 20),
        padding: const EdgeInsets.all(10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: EcoSenseTheme.darkGrey),
        ),
        child: isActive
            ? Column(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _focus,
                      controller: commentController,
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a comment',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: _postComment,
                        child: Text(
                          'Post',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: EcoSenseTheme.electricGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Images.userAvatar(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      focusNode: _focus,
                      controller: commentController,
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a comment',
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
