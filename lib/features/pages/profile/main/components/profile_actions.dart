import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/pages/home/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileActions extends ConsumerWidget {
  const ProfileActions(this.totalEcoPoints, {super.key});
  final int totalEcoPoints;

  Widget _ecoPoints() => Column(
        children: [
          Text(
            'Total EcoPoints',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              color: EcoSenseTheme.superDarkGray,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: EcoSenseTheme.darkGreen,
                child: SvgPicture.asset('assets/svgs/ecopoint.svg'),
              ),
              const SizedBox(width: 8),
              Text(
                '$totalEcoPoints',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  color: EcoSenseTheme.darkGreen,
                  fontSize: 34,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _getRewardButton(WidgetRef ref) => InkWell(
        onTap: () => ref.read(tabProvider.notifier).state.index = 2,
        child: Container(
          width: 134,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: EcoSenseTheme.verticalGradient,
          ),
          child: Center(
            child: Text(
              'Get Reward',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: EcoSenseTheme.darkGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ecoPoints(),
          _getRewardButton(ref),
        ],
      ),
    );
  }
}
