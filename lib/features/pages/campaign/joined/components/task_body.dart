// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/detail/campaign_detail_provider.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/campaign/campaign_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';

class TaskBody extends ConsumerStatefulWidget {
  const TaskBody(this.task, {super.key});
  final CampaignMission task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskBodyState();
}

class _TaskBodyState extends ConsumerState<TaskBody> {
  late TextEditingController controller;
  XFile? image;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  void _pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _submit() async {
    if (image == null) {
      Toasts.showFailedToast('Please select an image!', context);
      return;
    }
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      final response = await CampaignService.taskProof(
              widget.task.id, controller.text, image)
          .whenComplete(() => Navigator.pop(context));
      if (response) {
        Toasts.showSuccessToast('Submitted!', context);
      } else {
        Toasts.showFailedToast('went_wrong'.i18n(), context);
      }
      await Future.delayed(const Duration(seconds: 1));
      ref.read(campaignDetailProvider.notifier).state++;
    } catch (err) {
      Toasts.showFailedToast('went_wrong'.i18n(), context);
    }
  }

  Widget _uploadProofButton() => InkWell(
        onTap: _pickImage,
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: EcoSenseTheme.darkGreen),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svgs/paperclip.svg'),
              const SizedBox(width: 8),
              Text(
                image == null
                    ? 'profile_campaign_detail_mission_proof_button'.i18n()
                    : 'change_image'.i18n(),
                style: EcoSenseTheme.calloutTextStyle
                    .copyWith(color: EcoSenseTheme.darkGreen),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final hasSubmitted =
        widget.task.proofCaption != null || widget.task.photoUrl != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.name,
            style: GoogleFonts.plusJakartaSans(fontSize: 12),
          ),
          if (hasSubmitted) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: widget.task.photoUrl ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.task.proofCaption ?? '',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
          if (widget.task.completionStatus != 2 &&
              widget.task.completionStatus != 3) ...[
            const SizedBox(height: 8),
            _uploadProofButton(),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText:
                    'profile_campaign_detail_mission_experience_placeholder'
                        .i18n(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: EcoSenseTheme.grey)),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _submit,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: EcoSenseTheme.verticalGradient,
                  borderRadius: BorderRadius.circular(70),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    hasSubmitted ? 'Re-Submit' : 'Submit',
                    textAlign: TextAlign.center,
                    style: EcoSenseTheme.calloutTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
