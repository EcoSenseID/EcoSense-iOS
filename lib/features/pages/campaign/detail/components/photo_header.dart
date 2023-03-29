import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/theme.dart';

class CampaignDetailPhotoHeader extends StatelessWidget {
  const CampaignDetailPhotoHeader(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  Widget _categoryLabel(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: EcoSenseTheme.orange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CachedNetworkImage(
            imageUrl: campaign.posterUrl,
            height: 178,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 178,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF206A5D),
                Color(0x00206A5D),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 14,
          left: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/participant.svg',
                    color: Colors.white,
                    width: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${campaign.participantsCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: campaign.categories
                    .map((category) => _categoryLabel(category.name))
                    .toList(),
              ),
              const SizedBox(height: 4),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 50),
                child: Text(
                  campaign.title,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
