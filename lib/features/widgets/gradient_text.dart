import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    this.size = 23,
    super.key,
  });
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2!.copyWith(
            fontSize: size,
            foreground: Paint()
              ..shader = EcoSenseTheme.horizontalGradient
                  .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)),
          ),
      maxLines: 2,
    );
  }
}
