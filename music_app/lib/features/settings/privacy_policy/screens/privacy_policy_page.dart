import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/login_animation.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/settings/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:music_app/features/settings/privacy_policy/repository/privacy_policy_repository.dart';

final class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

final class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final PrivacyPolicyController _controller = PrivacyPolicyController(PrivacyPolicyRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _controller.getAgreement();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.darkGreyColor,
          appBar: CustomWidgets.appBar("Privacy Policy"),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Text(
              _controller.agreement.value,
            ),
          ),
        ),
        
        Obx(()=>LoadingAnimation(isLoading: _controller.isLoading.value)),
      ],
    );
  }
}
