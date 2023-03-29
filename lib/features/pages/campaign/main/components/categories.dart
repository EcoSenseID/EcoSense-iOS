import 'package:ecosense/features/pages/campaign/main/components/horizontal_categories.dart';
import 'package:ecosense/services/campaign/campaign_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../../data/models/category.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    _categoriesFuture = CampaignService.categories();
    super.initState();
  }

  // void _allCategoriesPressed(BuildContext context) {
  //   PersistentNavBarNavigator.pushNewScreen(context,
  //       screen: BrowseCategoryScreen());
  // }

  Widget _title(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'campaign_main_category_section'.i18n(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black),
            ),
            // GestureDetector(
            //   onTap: () => _allCategoriesPressed(context),
            //   child: Row(
            //     children: [
            //       Text('See All',
            //           style: TextStyle(color: EcoSenseTheme.darkGreen)),
            //       Icon(Icons.keyboard_arrow_right,
            //           color: EcoSenseTheme.darkGreen),
            //     ],
            //   ),
            // ),
          ],
        ),
      );

  Widget _categories(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150),
        child: FutureBuilder<List<CategoryModel>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text('Error');
            if (snapshot.hasData) return HorizontalCategories(snapshot.data!);
            return const CircularProgressIndicator();
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(context),
        const SizedBox(height: 20),
        _categories(context),
      ],
    );
  }
}
