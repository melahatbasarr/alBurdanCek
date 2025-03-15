import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/defeault_textfield.dart';
import 'package:music_app/common/widget/orange_button.dart';
import 'package:music_app/common/widget/password_textfield.dart';
import 'package:music_app/features/auth/register/controller/register_controller.dart';
import 'package:music_app/features/auth/username/screens/username_page.dart';
import '../../../../config/theme/custom_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _controller = Get.find<RegisterController>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      body: ListView(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 150),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(child: CustomWidgets.pageTitle("Sign Up")),
          const SizedBox(height: 30),
          
          DefaultTextField(
              title: "Email",
              controller: _emailController,
              iconData: Icons.email_outlined),
          const SizedBox(height: 12),
          PasswordTextField(title: "Password", controller: _passwordController),
          const SizedBox(height: 40),
          OrangeButton(title: "Devam Et", onTap: () => _checkFields()),
          const SizedBox(height: 10),
          _buildLoginText(),
        ],
      ),
    );
  }

  _buildLoginText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Already have an account ? ',
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: "Poppins Regular",
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                color: CustomColors.whiteText,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  _checkFields() {
   if (_emailController.text.isEmpty) {
      CustomWidgets.showSnackBar(message: "Please enter your email");
    } else if (_passwordController.text.isEmpty) {
      CustomWidgets.showSnackBar(message: "Please enter your password");
    } else {
      _controller.registerUser(
       
        email: _emailController.text,
        password: _passwordController.text,
        onSuccess: _onSuccess,
        onFailure: _onFailure,
      );
    }
  }

  // Success handler
  void _onSuccess() {
    
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernamePage()),
      (route) => false,
    );

    Get.offAll(() => const UsernamePage());
  }

  // Failure handler
  void _onFailure() {}
}
