import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosense/data/models/recent_campaign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../widgets/gradient_text.dart';
import '../../../campaign/detail/campaign_detail.dart';

class RecentCampaignWidget extends StatelessWidget {
  const RecentCampaignWidget(this.campaign, {super.key});
  final RecentCampaign campaign;

  Widget _categoryLabel() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          color: campaign.categories[0].color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          campaign.categories[0].name,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _ecopoints() {
    return Row(
      children: [
        SvgPicture.asset('assets/svgs/ecopoint.svg',
            color: EcoSenseTheme.darkGreen),
        const SizedBox(width: 4),
        Text('${campaign.earnedPoints}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: EcoSenseTheme.darkGreen,
            )),
        Text(' Eco Points',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: EcoSenseTheme.electricGreen,
            )),
      ],
    );
  }

  Widget _endDate() {
    final formatter = DateFormat("MMMM d, yyyy 'at' ").add_jm();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(campaign.caption),
        const SizedBox(height: 2),
        FittedBox(
          child: Text(
            formatter.format(campaign.widgetDate),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: CampaignDetailScreen(
          campaign.id,
          recordId: campaign.recordId,
        ),
        withNavBar: false,
      ),
      child: Container(
        height: 165,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: EcoSenseTheme.grey,
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child: CachedNetworkImage(
                imageUrl: campaign.posterUrl,
                width: 100,
                height: 165,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 168),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  GradientText(campaign.title, size: 21),
                  const SizedBox(height: 4),
                  _categoryLabel(),
                  const SizedBox(height: 4),
                  if (campaign.finishedAt != null) _ecopoints(),
                  const Spacer(),
                  _endDate(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
