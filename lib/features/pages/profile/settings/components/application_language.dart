import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';

class ApplicationLanguageWidget extends StatelessWidget {
  const ApplicationLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Application Language',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: EcoSenseTheme.verticalGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'English',
                    style: EcoSenseTheme.calloutTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: EcoSenseTheme.darkGrey),
                ),
                child: Center(
                  child: Text(
                    'Bahasa Indonesia',
                    style: EcoSenseTheme.calloutTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
