import 'package:collection/collection.dart';
import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CampaignTasks extends StatelessWidget {
  const CampaignTasks(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  Widget _buildTask(int index, CampaignMission task) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${index + 1}.',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: EcoSenseTheme.electricGreen,
                  )),
              const SizedBox(width: 4),
              Flexible(
                  child: Text(task.name, style: const TextStyle(fontSize: 12))),
            ],
          ),
          const Divider(thickness: 2),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Text(
          'profile_campaign_detail_mission_section_title'.i18n(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        const SizedBox(height: 8),
        ...campaign.missions
            .mapIndexed((index, task) => _buildTask(index, task)),
      ],
    );
  }
}
