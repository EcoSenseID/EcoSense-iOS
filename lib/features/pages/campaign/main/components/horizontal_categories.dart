import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/category.dart';
import 'package:ecosense/features/pages/campaign/list/campaign_list.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HorizontalCategories extends StatelessWidget {
  const HorizontalCategories(this.categories, {super.key});
  final List<CategoryModel> categories;

  EdgeInsets _categoryPadding(int index) {
    if (index == 0) return EdgeInsets.zero;
    if (index == categories.length - 1) return const EdgeInsets.only(right: 20);
    return EdgeInsets.zero;
  }

  Widget _allCategory(BuildContext context) => InkWell(
        onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
            screen: const CampaignListScreen(null)),
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 140,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(15, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 2,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/all_campaign.png'),
                Container(
                  width: 120,
                  height: 150,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF1CBC00),
                        Color(0x00000000),
                      ],
                      stops: [0, 0.5],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'campaign_campaign_list_title'.i18n(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildCategory(
          int index, CategoryModel category, BuildContext context) =>
      InkWell(
        onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
            screen: CampaignListScreen(category)),
        child: Container(
          margin: _categoryPadding(index),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 140,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(15, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 2,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: category.photoUrl,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: category.verticalGradient,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _allCategory(context),
        for (var i = 0; i < categories.length; i++)
          _buildCategory(i, categories[i], context),
      ],
    );
    // return ListView.separated(
    //   itemCount: categories.length,
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context, index) =>
    //       _buildCategory(index, categories[index], context),
    //   separatorBuilder: (BuildContext context, int index) =>
    //       const SizedBox(width: 20),
    // );
  }
}
