import 'package:ecosense/features/pages/profile/change_password/components/password_field.dart';
import 'package:ecosense/features/widgets/gradient_button.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePressed() {
    if (newPasswordController.text != confirmPasswordController.text) {
      Toasts.showFailedToast('Password does not match', context);
      return;
    }
    ProfileService.updatePassword(
            currentPasswordController.text, newPasswordController.text)
        .then((_) => Toasts.showSuccessToast('Password Changed', context))
        .catchError((error) => Toasts.showFailedToast(error.message, context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile_setting_change_pass_button'.i18n())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Spacer(),
              PasswordField(
                  label: 'profile_edit_profile_current_pass_caption'.i18n(),
                  controller: currentPasswordController),
              PasswordField(
                  label: 'profile_edit_profile_new_pass_caption'.i18n(),
                  controller: newPasswordController),
              PasswordField(
                  label: 'profile_edit_profile_retype_new_pass_caption'.i18n(),
                  controller: confirmPasswordController),
              const Spacer(),
              GradientButton(
                  text: 'profile_edit_profile_confirm_button'.i18n(),
                  handler: _savePressed),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
