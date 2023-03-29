import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Character-02.png',
            width: 190,
          ),
          Text(
            'This feature is under development\nStay tuned!',
            textAlign: TextAlign.center,
            style: EcoSenseTheme.underDevelopmentTextStyle,
          )
        ],
      ),
    );
  }
}
