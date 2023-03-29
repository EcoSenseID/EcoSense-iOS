import 'package:ecosense/features/widgets/under_development.dart';
import 'package:flutter/material.dart';

class EcoStoreScreen extends StatelessWidget {
  const EcoStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoStore')),
      body: const UnderDevelopment(),
    );
  }
}
