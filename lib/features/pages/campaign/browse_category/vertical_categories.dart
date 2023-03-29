import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalCategories extends StatelessWidget {
  const VerticalCategories(this.categories, {super.key});
  final List<CategoryModel> categories;

  EdgeInsets _buildCategoryPadding(int index) {
    if (index == 0) return const EdgeInsets.only(top: 20);
    if (index == categories.length - 1) {
      return const EdgeInsets.only(bottom: 20);
    }
    return EdgeInsets.zero;
  }

  Widget _buildCategory(BuildContext context, int index) {
    final category = categories[index];
    return Container(
      margin: _buildCategoryPadding(index),
      height: 100,
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
                gradient: category.horizontalGradient,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Text(
                    category.name.replaceAll(' ', '\n'),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemBuilder: (context, index) => _buildCategory(context, index),
      separatorBuilder: (context, index) => const SizedBox(height: 23),
      itemCount: categories.length,
    );
  }
}
