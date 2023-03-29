import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class NoCampaignDashboard extends StatelessWidget {
  const NoCampaignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Row(
            children: [
              Image.asset(
                'assets/images/Character-04.png',
                width: 140,
              ),
              Expanded(
                child: Text(
                  'profile_nohistory_caption'.i18n(),
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
