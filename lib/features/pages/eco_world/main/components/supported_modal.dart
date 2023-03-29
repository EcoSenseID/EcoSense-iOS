import 'package:ecosense/core/constants/theme.dart';
import 'package:ecosense/features/widgets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SupportedModal extends StatelessWidget {
  const SupportedModal({super.key});

  static showSupporters(BuildContext context) => showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        useRootNavigator: true,
        context: context,
        builder: (context) => const SupportedModal(),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              Text(
                'Supported by',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: EcoSenseTheme.darkGreen),
              ),
              IconButton(
                icon: SvgPicture.asset('assets/svgs/close.svg', width: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: ListView.builder(
              controller: ModalScrollController.of(context),
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Row(
                  children: [
                    Images.circle('https://i.pravatar.cc/300', radius: 23),
                    const SizedBox(width: 20),
                    Text(
                      'Supporter $index',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: EcoSenseTheme.darkGreen,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(width: 48),
//                 Text(
//                   'Supported by',
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline3!
//                       .copyWith(color: EcoSenseTheme.darkGreen),
//                 ),
//                 IconButton(
//                   icon: SvgPicture.asset('assets/svgs/close.svg', width: 20),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
