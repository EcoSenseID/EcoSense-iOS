import 'package:ecosense/features/pages/eco_world/main/components/eco_world_coming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../core/constants/theme.dart';
import '../../../../services/auth/auth_service.dart';
import '../../auth/login.dart';
import '../new_story/new_story.dart';
import 'components/paging_provider.dart';
import 'components/story_pagination.dart';

class EcoWorldScreen extends ConsumerStatefulWidget {
  const EcoWorldScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EcoWorldScreenState();
}

class _EcoWorldScreenState extends ConsumerState<EcoWorldScreen> {
  late PagingController _pagingController;

  @override
  void initState() {
    _pagingController = ref.read(pagingProvider);
    super.initState();
  }

  Widget _floatingButton(BuildContext context) => FloatingActionButton(
        onPressed: () {
          if (!AuthService.isLoggedIn()) {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: const LoginScreen(), withNavBar: false);
            return;
          }
          PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const NewStoryScreen(), withNavBar: false)
              .then((value) => _pagingController.refresh());
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: EcoSenseTheme.verticalGradient,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 36),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoWorld')),
      body: StoryPagination(),
      floatingActionButton: _floatingButton(context),
    );
  }
}
