import 'package:ecosense/features/pages/auth/components/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../../services/auth/auth_service.dart';
import '../../../../widgets/gradient_button.dart';
import '../../../../widgets/toast.dart';
import '../../../auth/components/auth_theme.dart';

class DeleteAccWithOauth extends StatefulWidget {
  const DeleteAccWithOauth({super.key});

  @override
  State<DeleteAccWithOauth> createState() => _DeleteAccWithOauthState();
}

class _DeleteAccWithOauthState extends State<DeleteAccWithOauth> {
  late TextEditingController _deleteController;
  bool mistyped = false;

  @override
  void initState() {
    super.initState();
    _deleteController = TextEditingController();
  }

  @override
  void dispose() {
    _deleteController.dispose();
    super.dispose();
  }

  void _submitPressed() async {
    if (_deleteController.text != 'account_delete_word'.i18n()) {
      setState(() {
        mistyped = true;
      });
      return;
    }
    await AuthService.deleteAccount()
        .catchError((error) => Toasts.showFailedToast(error.message, context));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 50),
        Text(
          'account_delete_title'.i18n(),
          style: GoogleFonts.plusJakartaSans(
              fontSize: 34, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 24),
        Text('account_delete_sub1'.i18n(),
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16, color: EcoSenseTheme.darkGreen)),
        const SizedBox(height: 4),
        Text('account_delete_sub2'.i18n(),
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: EcoSenseTheme.darkGreen,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text('account_delete_type'.i18n(),
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16, color: EcoSenseTheme.darkGreen)),
        const SizedBox(height: 12),
        AuthTextField(
            hintText: 'account_delete_word'.i18n(),
            controller: _deleteController),
        if (mistyped)
          Text('account_delete_didnt_match'.i18n(),
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 15, color: EcoSenseTheme.darkRed)),
        const SizedBox(height: 35),
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
