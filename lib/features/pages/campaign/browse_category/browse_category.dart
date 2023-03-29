import 'package:ecosense/features/pages/campaign/browse_category/vertical_categories.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../data/models/category.dart';
import '../../../../services/campaign/campaign_service.dart';

class BrowseCategoryScreen extends StatefulWidget {
  const BrowseCategoryScreen({super.key});

  @override
  State<BrowseCategoryScreen> createState() => _BrowseCategoryScreenState();
}

class _BrowseCategoryScreenState extends State<BrowseCategoryScreen> {
  late Future<List<CategoryModel>> _categoryFuture;

  @override
  void initState() {
    _categoryFuture = CampaignService.categories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('campaign_main_category_section'.i18n())),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoryFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Error');
          if (snapshot.hasData) return VerticalCategories(snapshot.data!);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
