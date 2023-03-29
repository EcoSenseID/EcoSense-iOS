import 'package:ecosense/features/widgets/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/gradient_text.dart';

class ProfileDetailVertical extends StatelessWidget {
  const ProfileDetailVertical({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Column(
      children: [
        Images.userAvatar(radius: 38),
        const SizedBox(height: 10),
        GradientText(user.displayName ?? 'Unnamed'),
        // Text('@username', style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
