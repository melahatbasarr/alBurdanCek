import 'package:flutter/material.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/features/settings/delete_account/screens/delete_account_page.dart';
import 'package:provider/provider.dart';
import 'package:music_app/features/settings/update_profile/controller/update_profile_controller.dart';
import 'package:music_app/config/theme/custom_colors.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<UpdateProfileController>().user;
    _usernameController = TextEditingController(text: user.username);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phoneNumber);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      appBar: CustomWidgets.appBar("Account"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                const SizedBox(height: 20),
                _buildInfoField("Username", _usernameController),
                _buildInfoField("Email", _emailController),
                _buildInfoField("Phone number", _phoneController),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeleteAccountPage(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Account closures",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: CustomColors.whiteText,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.orangeText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Update",
                        style: TextStyle(
                          color: CustomColors.darkGreyColor,
                          fontSize: 18,
                          fontFamily: "Poppins-bold",
                        ),
                      ),
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(CustomColors.orangeText),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.title(label, color: Colors.white),
          const SizedBox(height: 3),
          TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontFamily: "Poppins-bold",
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.orangeText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updatedUsername = _usernameController.text;
      final updatedEmail = _emailController.text;
      final updatedPhone = _phoneController.text;

      context.read<UpdateProfileController>().updateUser(
            username: updatedUsername,
            email: updatedEmail,
            phoneNumber: updatedPhone,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The profile has been successfully updated!")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
