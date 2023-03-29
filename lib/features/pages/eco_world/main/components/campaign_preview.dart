import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/story.dart';
import 'package:ecosense/features/pages/campaign/detail/campaign_detail.dart';
import 'package:ecosense/features/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CampaignPreview extends StatelessWidget {
  const CampaignPreview(this.campaign, {super.key});
  final SharedCampaign campaign;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: CampaignDetailScreen(campaign.id), withNavBar: false),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 278,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: const Color(0xFFFCFCFE),
              boxShadow: [EcoSenseTheme.boxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    campaign.title,
                    size: 15,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: campaign.categories
                        .map(
                          (category) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: category.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              category.name,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: campaign.posterUrl,
              width: 278,
              height: 122,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
