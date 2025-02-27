import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/defeault_textfield.dart';
import 'package:music_app/common/widget/orange_button.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/auth/login/screens/login_page.dart';
import 'package:music_app/features/auth/username/controller/username_controller.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final UsernameController _controller = Get.find<UsernameController>();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      body: ListView(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 150),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: CustomWidgets.pageTitle("Kullanıcı Adınızı Giriniz"),
          ),
          const SizedBox(height: 30),
          DefaultTextField(
              title: "Kullanıcı Adınız", controller: _usernameController),
          const SizedBox(height: 40),
          OrangeButton(title: "Sign Up", onTap: () => _checkFields()),
        ],
      ),
    );
  }

  _checkFields() {
    if (_usernameController.text.isEmpty) {
      CustomWidgets.showSnackBar(message: "Please enter your username.");
    } else {
      _controller.checkUsername(
          username: _usernameController.text,
          onSuccess: _onSuccess,
          onFailure: _onFailure);
    }
  }

  void _onSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );

    Get.offAll(() => const LoginPage());
  }

  void _onFailure() {}
}
