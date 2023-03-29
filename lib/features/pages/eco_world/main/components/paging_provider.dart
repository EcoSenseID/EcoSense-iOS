import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../data/models/story.dart';

final pagingProvider =
    Provider((ref) => PagingController<int, StoryModel>(firstPageKey: 0));
