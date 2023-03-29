// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/features/pages/eco_world/main/components/campaign_preview.dart';
import 'package:ecosense/features/widgets/images.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/story/story.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

import '../../../widgets/loading.dart';

class NewStoryScreen extends StatefulWidget {
  const NewStoryScreen({this.caption, this.campaign, super.key});
  final String? caption;
  final SharedCampaign? campaign;

  @override
  State<NewStoryScreen> createState() => _NewStoryScreenState();
}

class _NewStoryScreenState extends State<NewStoryScreen> {
  late TextEditingController storyController;
  XFile? photo;

  @override
  void initState() {
    storyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  void _postPressed(BuildContext context) async {
    if (storyController.text.isEmpty) {
      Toasts.showFailedToast('Caption cannot be empty!', context);
      return;
    }
    showDialog(context: context, builder: (_) => const Loading());
    final success = await StoryService.postStory(
      caption: storyController.text,
      sharedCampaignId: widget.campaign?.id,
      attachedPhoto: photo,
    );
    Navigator.of(context).pop();
    if (success) {
      Toasts.showSuccessToast('Story posted', context);
      Navigator.of(context).pop();
    } else {
      Toasts.showFailedToast('went_wrong'.i18n(), context);
    }
  }

  void _pickImage() async {
    photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoWorld')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Images.circle(FirebaseAuth.instance.currentUser!.photoURL,
                    radius: 21),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    // height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: EcoSenseTheme.darkGrey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: storyController,
                            style: const TextStyle(fontSize: 12),
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                          if (photo != null) ...[
                            const SizedBox(height: 8),
                            Image.file(
                              File(photo!.path),
                              // height: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                          ],
                          if (widget.campaign != null) ...[
                            CampaignPreview(widget.campaign!),
                            const SizedBox(height: 8),
                          ],
                          Row(
                            children: [
                              InkWell(
                                onTap: _pickImage,
                                child:
                                    SvgPicture.asset('assets/svgs/image.svg'),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => _postPressed(context),
                                child: const Text('Post',
                                    style: TextStyle(
                                        color: EcoSenseTheme.electricGreen)),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
