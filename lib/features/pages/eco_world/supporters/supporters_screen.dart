import 'package:ecosense/data/models/supporter.dart';
import 'package:ecosense/features/widgets/loading.dart';
import 'package:ecosense/features/widgets/something_went_wrong.dart';
import 'package:ecosense/services/story/story.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../core/constants/theme.dart';
import '../../../widgets/images.dart';

class SupporterScreen extends StatefulWidget {
  const SupporterScreen(this.storyId, {super.key});
  final int storyId;

  @override
  State<SupporterScreen> createState() => _SupporterScreenState();
}

class _SupporterScreenState extends State<SupporterScreen> {
  late Future<List<Supporter>> _supportersFuture;

  @override
  void initState() {
    _supportersFuture = StoryService.getSupporters(widget.storyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ecoWorld_supported_title'.i18n()),
      ),
      body: FutureBuilder<List<Supporter>>(
        future: _supportersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final supporters = snapshot.data!;
            return ListView.builder(
              itemCount: supporters.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Row(
                  children: [
                    Images.circle(supporters[index].avatarUrl, radius: 23),
                    const SizedBox(width: 20),
                    Text(
                      supporters[index].name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: EcoSenseTheme.darkGreen,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) return const SomethingWentWrong();
          return const Loading();
        },
      ),
    );
  }
}
