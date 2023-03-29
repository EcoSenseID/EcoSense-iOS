import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/joined/components/accordion_task.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class JoinedTasks extends StatefulWidget {
  const JoinedTasks(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  @override
  State<JoinedTasks> createState() => _JoinedTasksState();
}

class _JoinedTasksState extends State<JoinedTasks> {
  List<bool> isExpandedState = [];

  @override
  void initState() {
    isExpandedState = [
      for (int i = 0; i < widget.campaign.missions.length; i++) false,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          'profile_campaign_detail_mission_section_title'.i18n(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        const SizedBox(width: double.infinity),
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) => setState(() {
            isExpandedState[panelIndex] = !isExpanded;
          }),
          elevation: 0,
          dividerColor: EcoSenseTheme.grey,
          children: [
            for (int i = 0; i < widget.campaign.missions.length; i++)
              AccordionTask.panel(
                  i, widget.campaign.missions[i], isExpandedState[i], context)
          ],
        ),
      ],
    );
  }
}
