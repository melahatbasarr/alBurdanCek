import 'package:flutter/material.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/settings/privacy_policy/screens/privacy_policy_page.dart';
import 'package:music_app/features/settings/update_password/screens/update_password_page.dart';

class PrivacySocialPage extends StatefulWidget {
  const PrivacySocialPage({super.key});

  @override
  State<PrivacySocialPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacySocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.appBar("Privacy & Social"),
      backgroundColor: CustomColors.darkGreyColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            title: "Update Your Password",
            icon: Icons.lock,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdatePasswordPage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            title: "Privacy Policy",
            icon: Icons.privacy_tip,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.grey,
                ),
                const SizedBox(width: 15),
                CustomWidgets.title(title, color: Colors.white)
              ],
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
}
