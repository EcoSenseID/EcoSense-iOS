// ignore_for_file: use_build_context_synchronously

import 'package:ecosense/data/models/reward_detail.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/form_validator.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/small_gradient_button.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/small_outlined_button.dart';
import 'package:ecosense/features/pages/eco_reward/reward_detail/components/submitted_reward.dart';
import 'package:ecosense/features/widgets/part_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import '../../../../../core/constants/theme.dart';
import '../../../../../services/reward/reward.dart';
import '../../../../widgets/loading.dart';

class RewardForm extends ConsumerStatefulWidget {
  const RewardForm(this.reward, {super.key});
  final RewardDetail reward;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RewardFormState();
}

class _RewardFormState extends ConsumerState<RewardForm> {
  static const eWallets = ['Go-Pay', 'DANA', 'OVO'];
  String? _selectedWallet;
  late TextEditingController _emailController, _numberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _sendPressed() async {
    if (!_formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (_) => const Loading(),
      barrierDismissible: false,
    );
    final success = await RewardService.requestReward(
      widget.reward.id,
      _emailController.text,
      _selectedWallet!,
      _numberController.text,
    );
    // .then((value) {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pop();
    // }).onError((error, stackTrace) {
    //   Navigator.of(context).pop();
    //   Toasts.showFailedToast('went_wrong'.i18n(), context);
    // });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    if (success) {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        isScrollControlled: true,
        builder: (context) => const SubmittedReward(),
      );
    }
  }

  InputDecoration _inputStyle(String hint) => InputDecoration(
        isDense: true,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      );

  Widget _formField(String title, String hint, TextEditingController controller,
          TextInputType keyboardType) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          PartTitle(title),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: keyboardType == TextInputType.emailAddress
                  ? RewardFormValidator.validateEmail
                  : RewardFormValidator.validateNumber,
              style: GoogleFonts.plusJakartaSans(fontSize: 14),
              decoration: _inputStyle(hint),
            ),
          ),
        ],
      );

  Widget _chooseWallet() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          PartTitle('reward_redeem_form_ewallet_field_title'.i18n()),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: DropdownButtonFormField<String>(
              decoration:
                  _inputStyle('reward_redeem_form_ewallet_placeholder'.i18n()),
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14, color: EcoSenseTheme.superDarkGray),
              validator: (value) => value == null
                  ? 'Please choose an e-wallet provider'.i18n()
                  : null,
              borderRadius: BorderRadius.circular(16),
              isExpanded: true,
              items: eWallets
                  .map((wallet) => DropdownMenuItem(
                        value: wallet,
                        child: Text(wallet),
                      ))
                  .toList(),
              value: _selectedWallet,
              onChanged: (value) {
                setState(() => _selectedWallet = value);
                // _formKey.currentState!.validate();
              },
            ),
          ),
        ],
      );

  Widget _form(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            _formField(
              'login_email_placeholder'.i18n(),
              'reward_redeem_form_email_placeholder'.i18n(),
              _emailController,
              TextInputType.emailAddress,
            ),
            _chooseWallet(),
            _formField(
              'reward_redeem_form_ewallet_number_field_title'.i18n(),
              'reward_redeem_form_ewallet_number_placeholder'.i18n(),
              _numberController,
              TextInputType.number,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 550),
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFCDEEDD),
                  boxShadow: [EcoSenseTheme.boxShadow],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'reward_redeem_form_title'.i18n(),
                        style: GoogleFonts.rubik(
                          color: EcoSenseTheme.darkGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _form(context),
              const SizedBox(height: 28),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'reward_redeem_form_caption1'.i18n(),
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'reward_redeem_form_caption2'.i18n(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'reward_redeem_form_caption3'.i18n(),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: 'reward_redeem_form_caption4'.i18n(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallOutlinedButton('reward_redeem_form_cancel_button'.i18n(),
                      Navigator.of(context).pop),
                  const SizedBox(width: 12),
                  SmallGradientButton(
                      'reward_redeem_form_submit_button'.i18n(), _sendPressed),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
