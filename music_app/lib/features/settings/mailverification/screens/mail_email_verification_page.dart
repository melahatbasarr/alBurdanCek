import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/defeault_textfield.dart';
import 'package:music_app/common/widget/login_animation.dart';
import 'package:music_app/common/widget/orange_button.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/settings/mailverification/controller/mail_verification_controller.dart';
import 'package:music_app/features/settings/mailverification/screens/mailverification_page.dart';

class MailEmailVerificationPage extends StatefulWidget {
  const MailEmailVerificationPage({super.key});

  @override
  State<MailEmailVerificationPage> createState() => _MailEmailVerificationPageState();
}

class _MailEmailVerificationPageState extends State<MailEmailVerificationPage> {
  final MailVerificationController _controller = Get.put(MailVerificationController());
  final TextEditingController _emailController = TextEditingController();
  final RxBool _isValidEmail = false.obs;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    _isValidEmail.value = emailRegex.hasMatch(_emailController.text);
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
                title: "Email Address",
                controller: _emailController,
                iconData: Icons.email_outlined,
              ),
              const SizedBox(height: 15),
              Obx(() => OrangeButton(
                    title: "Continue",
                    onTap: _isValidEmail.value ? () => _continueToVerification() : () => _showInvalidEmailMessage(),
                  )),
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
        "Please enter your email address to receive a verification code.",
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: "Poppins Regular",
        ),
      ),
    );
  }

  void _continueToVerification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MailVerificationPage(
          email: _emailController.text,
        ),
      ),
    );
  }

  void _showInvalidEmailMessage() {
    CustomWidgets.showSnackBar(message: "Please enter a valid email address");
  }
} 