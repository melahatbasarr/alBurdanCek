import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/home/controller/home_controller.dart';
import 'package:music_app/features/settings/settings/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                _buildSearchAndAvatarRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchAndAvatarRow() {
    return Row(
      children: [
        Expanded(
          child: _buildSearchField(),
        ),
        const SizedBox(width: 10),
        _buildAvatar(),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _controller.searchController,
      onChanged: _controller.onSearchChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: 'Ara...',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ),
        );
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(_controller.user.avatarUrl),
        radius: 20,
      ),
    );
  }
}
