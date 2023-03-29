import 'package:ecosense/features/widgets/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/gradient_text.dart';

class ProfileDetailHorizontal extends StatelessWidget {
  const ProfileDetailHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Images.userAvatar(radius: 30),
            const SizedBox(width: 22),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(user.displayName ?? 'Unnamed'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
