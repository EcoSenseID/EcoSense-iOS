import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/joined/components/task_body.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AccordionTask {
  static ExpansionPanel panel(int index, CampaignMission task, bool isExpanded,
          BuildContext context) =>
      ExpansionPanel(
        isExpanded: isExpanded,
        headerBuilder: (context, isExpanded) => ListTile(
          leading: Icon(Icons.check_circle, color: task.color),
          title: Text('${'mission'.i18n()} ${index + 1}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: task.color,
                    fontWeight: FontWeight.bold,
                  )),
        ),
        body: TaskBody(task),
      );
}
