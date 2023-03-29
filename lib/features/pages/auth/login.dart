import 'dart:async';

import 'package:ecosense/features/pages/auth/components/apple_button.dart';
import 'package:ecosense/features/pages/auth/components/auth_password_fielt.dart';
import 'package:ecosense/features/pages/auth/components/auth_text_field.dart';
import 'package:ecosense/features/pages/auth/components/google_button.dart';
import 'package:ecosense/features/pages/auth/components/navbar.dart';
import 'package:ecosense/features/pages/auth/components/text_button.dart';
import 'package:ecosense/features/widgets/gradient_button.dart';
import 'package:ecosense/features/widgets/toast.dart';
import 'package:ecosense/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../core/routes/routes.dart';
import 'components/auth_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late StreamSubscription<User?> _userSubscription;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) Navigator.popAndPushNamed(context, Routes.home);
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userSubscription.cancel();
    super.dispose();
  }

  Widget get _loginForm => Form(
        key: _formKey,
        child: Column(
          children: [
            AuthTextField(
                hintText: 'login_email_placeholder'.i18n(),
                controller: _emailController),
            const SizedBox(height: 5),
            AuthPasswordField(
                label: 'login_pass_placeholder'.i18n(),
                controller: _passwordController),
            Align(
              alignment: Alignment.centerRight,
              child: AuthTextButton(
                  text: 'login_forgot_pass_link'.i18n(),
                  handler: forgotPasswordHandler),
            ),
            const SizedBox(height: 40),
            GradientButton(
                text: 'login_login_button_caption'.i18n(),
                handler: loginHandler),
          ],
        ),
      );

  void createAccountHandler() =>
      Navigator.of(context).popAndPushNamed('/register');

  void loginHandler() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text;
    final password = _passwordController.text;
    await AuthService.signInWithEmailAndPassword(
      email,
      password,
    ).catchError(
      (error) {
        Toasts.showFailedToast(error.message ?? 'went_wrong'.i18n(), context);
      },
    ).then((user) {
      if (user != null) {
        // Toasts.showSuccessToast('Login successful', context);
      }
    });
  }

  void googleSignInHandler() async {
    AuthService.googleSignIn().catchError(
      (error) {
        Toasts.showFailedToast(error.message ?? 'went_wrong'.i18n(), context);
      },
    ).then((user) {
      if (user != null) {
        // Toasts.showSuccessToast('Login successful', context);
      }
    });
  }

  void _appleSignInHandler() async {
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

  void forgotPasswordHandler() async {
    await AuthService.forgotPassword(_emailController.text)
        .then((value) => Toasts.showSuccessToast('Email sent!', context))
        .catchError((error) => Toasts.showFailedToast(error.message, context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const AuthNavBar(),
              const SizedBox(height: 72),
              Text(
                'login_login_title'.i18n(),
                style: AuthTheme.h1,
              ),
              const SizedBox(height: 30),
              _loginForm,
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.center,
                child: Text('login_or_caption'.i18n(), style: AuthTheme.body1),
              ),
              const SizedBox(height: 16),
              GoogleButton(handler: googleSignInHandler),
              const SizedBox(height: 10),
              AppleButton(handler: _appleSignInHandler),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('login_register_caption'.i18n(), style: AuthTheme.body2),
                  AuthTextButton(
                      text: 'login_register_link'.i18n(),
                      handler: createAccountHandler),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
