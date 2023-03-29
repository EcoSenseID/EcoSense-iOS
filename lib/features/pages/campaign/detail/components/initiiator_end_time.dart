import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/data/models/campaign_detail.dart';
import 'package:ecosense/features/pages/campaign/detail/components/end_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

class InitiatorEndTime extends StatelessWidget {
  const InitiatorEndTime(this.campaign, {super.key});
  final CampaignDetailModel campaign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svgs/initiator.svg'),
            Text(
              '  ${'profile_campaign_detail_intiaitor_caption'.i18n()} ',
              style: GoogleFonts.plusJakartaSans(fontSize: 11),
            ),
            Text(
              campaign.initiator,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: EcoSenseTheme.darkGreen),
            )
          ],
        ),
        if (campaign.isOpen) ...[
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            height: 25,
            decoration: const BoxDecoration(
              color: EcoSenseTheme.darkGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Center(
              child: Text(
                'profile_campaign_detail_deadline_caption'.i18n(),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          EndTime(campaign.endDate)
        ],
      ],
    );
  }
}
