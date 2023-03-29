import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/features/pages/eco_world/main/components/paging_provider.dart';
import 'package:ecosense/features/pages/eco_world/main/components/story_preview.dart';
import 'package:ecosense/services/story/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoryPagination extends ConsumerStatefulWidget {
  const StoryPagination({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoryPaginationState();
}

class _StoryPaginationState extends ConsumerState<StoryPagination> {
  static const _pageSize = 4;

  late PagingController<int, StoryModel> _pagingController;

  @override
  void initState() {
    _pagingController = ref.read(pagingProvider);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    StoryService.getStories(pageKey, _pageSize);
    try {
      final newItems = await StoryService.getStories(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    StoryService.getStories(0, 4);
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView<int, StoryModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<StoryModel>(
          itemBuilder: (context, item, index) => StoryPreview(item),
        ),
      ),
    );
  }
}

// class StoryPagination extends StatefulWidget {
//   const StoryPagination({super.key});

//   @override
//   State<StoryPagination> createState() => _StoryPaginationState();
// }

// class _StoryPaginationState extends State<StoryPagination> {
//   static const _pageSize = 4;

//   final PagingController<int, StoryModel> _pagingController =
//       PagingController(firstPageKey: 0);

//   @override
//   void initState() {
//     _pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });
//     super.initState();
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     StoryService.getStories(pageKey, _pageSize);
//     try {
//       final newItems = await StoryService.getStories(pageKey, _pageSize);
//       final isLastPage = newItems.length < _pageSize;
//       if (isLastPage) {
//         _pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + newItems.length;
//         _pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     StoryService.getStories(0, 4);
//     return RefreshIndicator(
//       onRefresh: () => Future.sync(
//         () => _pagingController.refresh(),
//       ),
//       child: PagedListView<int, StoryModel>(
//         pagingController: _pagingController,
//         builderDelegate: PagedChildBuilderDelegate<StoryModel>(
//           itemBuilder: (context, item, index) => StoryPreview(item),
//         ),
//       ),
//     );
//   }
// }
