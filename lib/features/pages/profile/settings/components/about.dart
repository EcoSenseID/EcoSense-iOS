import 'package:ecosense/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';

class AboutEcoSense extends StatelessWidget {
  const AboutEcoSense({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'profile_setting_about_section_title'.i18n(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: EcoSenseTheme.darkGrey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/svgs/version.svg'),
              const SizedBox(width: 12),
              Text('profile_setting_version_button'.i18n(),
                  style: EcoSenseTheme.calloutTextStyle),
              const Expanded(child: SizedBox()),
              Text('1.0.3', style: EcoSenseTheme.calloutTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
