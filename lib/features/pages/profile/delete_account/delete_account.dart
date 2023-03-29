import 'package:ecosense/features/pages/profile/delete_account/components/delete_with_oauth.dart';
import 'package:ecosense/features/pages/profile/delete_account/components/delete_with_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child:
            FirebaseAuth.instance.currentUser!.providerData.first.providerId ==
                    'password'
                ? const DeleteAccWithPassword()
                : const DeleteAccWithOauth(),
      ),
    );
  }
}
