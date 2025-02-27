import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/controller/user_controller.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/auth/login/screens/login_page.dart';
import 'package:music_app/features/settings/about/screens/about_page.dart';
import 'package:music_app/features/settings/privacy_social/screens/privacy_social_page.dart';
import 'package:music_app/features/settings/settings/controller/settings_controller.dart';
import 'package:music_app/features/settings/update_profile/screens/update_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

final class _SettingsPageState extends State<SettingsPage> {
  final SettingsController _controller = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();
    _controller.name.value = "${UserController.name} ${UserController.surname}";
    _controller.email.value = UserController.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      body: ListView(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildUserInfo(),
          const SizedBox(height: 30),
          _buildMenuItem(
            "Account",
            Icons.person,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UpdateProfilePage()),
            ),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            "Privacy & Social",
            Icons.lock,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PrivacySocialPage()),
            ),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            "About",
            Icons.privacy_tip,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AboutPage()),
            ),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            "Log out",
            Icons.logout,
            _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: CustomColors.darkGreyColor,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: const AssetImage("assets/images/profilphoto.png"),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      _controller.name.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins Medium",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Obx(() => Text(
                      _controller.email.value,
                      style: const TextStyle(
                        fontFamily: "Poppins Medium",
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomWidgets.title(title)
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("token");
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }
}
