import 'dart:io';

import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/widgets/gradient_button.dart';
import 'package:ecosense/features/widgets/images.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  XFile? photo;

  @override
  void initState() {
    fullNameController = TextEditingController(text: user.displayName);
    emailController = TextEditingController(text: user.email);
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => photo = image);
    }
  }

  AppBar _appBar() => AppBar(
        title: Text('profile_edit_profile_title'.i18n()),
      );

  Widget _profilePhoto() => GestureDetector(
        onTap: _pickImage,
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Stack(
              children: [
                photo != null
                    ? CircleAvatar(
                        radius: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image.file(
                            File(photo!.path),
                            fit: BoxFit.cover,
                            width: 90,
                          ),
                        ))
                    : Images.userAvatar(radius: 45),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 12.5,
                    backgroundColor: EcoSenseTheme.darkGreen,
                    child: Icon(Icons.edit_outlined, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _textField(
          String hint, TextEditingController controller, bool enabled) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hint, style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 10),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration:
                EcoSenseTheme.profileTextFieldStyle.copyWith(hintText: hint),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: enabled ? Colors.black : EcoSenseTheme.superDarkGray,
                ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _editProfileForm() => Column(
        children: [
          const SizedBox(height: 40),
          _profilePhoto(),
          const SizedBox(height: 4),
          _textField(
              'signUp_name_placeholder'.i18n(), fullNameController, true),
          _textField(
            'Email',
            emailController,
            FirebaseAuth.instance.currentUser!.providerData
                .any((element) => element.providerId == 'password'),
          ),
          const Spacer(),
          GradientButton(
            text: 'profile_edit_profile_save_button'.i18n(),
            handler: _savePressed,
          ),
          const SizedBox(height: 24),
        ],
      );

  void _savePressed() async {
    await ProfileService.updateProfile(
      fullName: fullNameController.text,
      email: emailController.text,
      photo: photo,
    ).then((_) {
      Toasts.showSuccessToast('Profile Updated', context);
      Navigator.of(context).pop();
    }).catchError((error) {
      Toasts.showFailedToast(error.message, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: _editProfileForm(),
      ),
    );
  }
}
