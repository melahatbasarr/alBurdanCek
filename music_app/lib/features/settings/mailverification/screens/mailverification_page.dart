import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/defeault_textfield.dart';
import 'package:music_app/common/widget/login_animation.dart';
import 'package:music_app/common/widget/orange_button.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/settings/mailverification/controller/mail_verification_controller.dart';

class MailVerificationPage extends StatefulWidget {
  final String email;
  
  const MailVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<MailVerificationPage> createState() => _MailVerificationPageState();
}

class _MailVerificationPageState extends State<MailVerificationPage> {
  final MailVerificationController _controller = Get.put(MailVerificationController());
  final TextEditingController _verificationCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Send verification code to email when page opens
    _controller.sendVerificationCode(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.darkGreyColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Email Verification",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins Medium",
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
            physics: const BouncingScrollPhysics(),
            children: [
              Center(child: CustomWidgets.pageTitle("Verify Your Email")),
              const SizedBox(height: 20),
              _buildInfoText(),
              const SizedBox(height: 40),
              DefaultTextField(
                title: "Verification Code",
                controller: _verificationCodeController,
                iconData: Icons.security,
              ),
              const SizedBox(height: 15),
              OrangeButton(
                title: "Verify Email",
                onTap: () => _verifyCode(),
              ),
              const SizedBox(height: 15),
              _buildResendButton(),
            ],
          ),
        ),
        Obx(() => LoadingAnimation(isLoading: _controller.isLoading.value)),
      ],
    );
  }

  Widget _buildInfoText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "We've sent a verification code to ${widget.email}. Please enter the code below to verify your account.",
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: "Poppins Regular",
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          _resendVerificationCode();
        },
        child: const Text(
          "Didn't receive a code? Send again",
          style: TextStyle(
            color: CustomColors.whiteText,
            fontSize: 14,
            fontFamily: "Poppins Regular",
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  void _verifyCode() async {
    if (_verificationCodeController.text.isEmpty) {
      CustomWidgets.showSnackBar(message: "Please enter verification code");
    } else if (_verificationCodeController.text.length != 6) {
      CustomWidgets.showSnackBar(message: "Verification code must be 6 digits");
    } else {
      bool success = await _controller.verifyCode(_verificationCodeController.text);
      if (success && mounted) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      }
    }
  }

  void _resendVerificationCode() async {
    await _controller.sendVerificationCode(widget.email);
  }
} 