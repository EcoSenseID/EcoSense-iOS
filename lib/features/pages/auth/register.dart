import 'dart:async';

import 'package:ecosense/features/pages/auth/components/apple_button.dart';
import 'package:ecosense/features/widgets/gradient_button.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/theme.dart';
import 'components/auth_password_fielt.dart';
import 'package:ecosense/features/pages/auth/components/auth_text_field.dart';
import 'package:ecosense/features/pages/auth/components/auth_theme.dart';
import 'package:ecosense/features/pages/auth/components/navbar.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/routes.dart';
import 'components/google_button.dart';
import 'components/text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agree = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  late StreamSubscription<User?> _userSubscription;

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.popAndPushNamed(context, Routes.home);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    _userSubscription.cancel();
    super.dispose();
  }

  String? passwordConfirmValidator(String? password) {
    if (password == null) return 'Must not be empty';
    if (password == '') return 'Must not be empty';
    if (passwordController.text != passwordConfirmController.text) {
      return 'Password does not match';
    }
    return null;
  }

  Widget get _registerForm => Form(
        key: _formKey,
        child: Column(
          children: [
            AuthTextField(
                hintText: 'signUp_name_placeholder'.i18n(),
                controller: fullNameController),
            AuthTextField(
                hintText: 'login_email_placeholder'.i18n(),
                controller: emailController),
            AuthPasswordField(
                label: 'login_pass_placeholder'.i18n(),
                controller: passwordController),
            AuthPasswordField(
                label: 'signUp_repeat_pass_placeholder'.i18n(),
                controller: passwordConfirmController,
                validator: passwordConfirmValidator),
            Row(
              children: [
                Checkbox(
                    activeColor: EcoSenseTheme.electricGreen,
                    value: _agree,
                    onChanged: (value) => setState(() => _agree = value!)),
                Text(
                  'signUp_agreement_caption1'.i18n(),
                  style: AuthTheme.sub1,
                ),
                TextButton(
                  onPressed: (() async {
                    await launchUrl(
                        Uri.parse('https://ecosense.id/privacy-policy'));
                  }),
                  child: Text('signUp_agreement_privacy_link'.i18n(),
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GradientButton(
                text: 'signUp_create_button'.i18n(), handler: registerHandler),
          ],
        ),
      );

  void loginHandler() => Navigator.of(context).popAndPushNamed('/login');

  void googleSignUpHandler() async {
    await AuthService.googleSignIn().catchError(
      (error) {
        Toasts.showFailedToast(error.message ?? 'went_wrong'.i18n(), context);
      },
    ).then((user) {
      if (user != null) {
        // Toasts.showSuccessToast('Register successful', context);
      }
    });
  }

  void _appleSignUpHandler() async {
    await AuthService.appleSignIn().catchError(
      (error) {
        Toasts.showFailedToast(error.message ?? 'went_wrong'.i18n(), context);
      },
    ).then((user) {
      if (user != null) {
        // Toasts.showSuccessToast('Register successful', context);
      }
    });
  }

  void registerHandler() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      Toasts.showFailedToast('Must agree to Terms and Privacy Policy', context);
      return;
    }

    await AuthService.signUp(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
    ).catchError((error) {
      Toasts.showFailedToast(error.message, context);
    }).then((user) {
      if (user != null) Toasts.showSuccessToast('User signed up', context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthNavBar(),
              const SizedBox(height: 24),
              Text('signUp_welcome_title'.i18n(), style: AuthTheme.h1),
              const SizedBox(height: 20),
              _registerForm,
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.center,
                child: Text('signUp_or_caprion'.i18n(), style: AuthTheme.body1),
              ),
              const SizedBox(height: 16),
              GoogleButton(handler: googleSignUpHandler),
              const SizedBox(height: 10),
              AppleButton(handler: _appleSignUpHandler),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('signUp_login_caption'.i18n(), style: AuthTheme.body2),
                  AuthTextButton(
                      text: 'login_login_button_caption'.i18n(),
                      handler: loginHandler),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
