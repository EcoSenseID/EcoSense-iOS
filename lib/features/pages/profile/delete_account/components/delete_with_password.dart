import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../widgets/gradient_button.dart';
import '../../../auth/components/auth_password_fielt.dart';
import '../../../auth/components/auth_theme.dart';

class DeleteAccWithPassword extends StatefulWidget {
  const DeleteAccWithPassword({super.key});

  @override
  State<DeleteAccWithPassword> createState() => _DeleteAccWithPasswordState();
}

class _DeleteAccWithPasswordState extends State<DeleteAccWithPassword> {
  final _passwordController = TextEditingController();

  void _submitPressed() async {
    await AuthService.deleteAccount(password: _passwordController.text)
        .catchError((error) => Toasts.showFailedToast(error.message, context));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 100),
        Text(
          'account_delete_title'.i18n(),
          style: GoogleFonts.plusJakartaSans(
              fontSize: 34, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text('account_insert_password'.i18n(),
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16, color: EcoSenseTheme.darkGreen)),
        const SizedBox(height: 12),
        AuthPasswordField(
            label: 'profile_edit_profile_pass_placeholder'.i18n(),
            controller: _passwordController),
        const SizedBox(height: 65),
        Text('account_delete_confirm'.i18n(),
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16, color: EcoSenseTheme.darkGreen)),
        const SizedBox(height: 12),
        GradientButton(
            text: 'account_delete_confirm_button'.i18n(),
            handler: _submitPressed),
        const SizedBox(height: 18),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: EcoSenseTheme.darkGreen),
              borderRadius: BorderRadius.circular(70),
            ),
            width: double.infinity,
            child: Center(
              child: Text(
                'account_back_profile'.i18n(),
                textAlign: TextAlign.center,
                style: AuthTheme.buttonTextTheme.copyWith(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
