import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';

class EndTime extends StatefulWidget {
  const EndTime(this.endTime, {super.key});
  final DateTime endTime;

  @override
  State<EndTime> createState() => _EndTimeState();
}

class _EndTimeState extends State<EndTime> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _campaignEnd() {
    final left = widget.endTime.difference(DateTime.now());
    final day = left.inDays;
    final hour = left.inHours % 24;
    final minute = left.inMinutes % 60;
    final second = left.inSeconds % 60;
    return '$day ${'days'.i18n()} $hour ${'hours'.i18n()} $minute ${'minutes'.i18n()} $second ${'seconds'.i18n()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
        color: EcoSenseTheme.mintGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: Center(
        child: Text(
          _campaignEnd(),
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: EcoSenseTheme.darkGreen,
          ),
        ),
      ),
    );
  }
}
