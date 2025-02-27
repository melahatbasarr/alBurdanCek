import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/mini_player/screens/mini_player_page.dart';
import 'package:music_app/features/navigator/controller/navigator_controller.dart';

final class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

final class _NavigatorPageState extends State<NavigatorPage> {
  final NavigatorController _controller = Get.put(NavigatorController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Obx(
            () => _controller.pages[_controller.currentIndex.value],
          ),
          bottomNavigationBar: Obx(
            () => BottomAppBar(
              elevation: 0,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Container(
                height: 80,
                color: CustomColors.darkGreyColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildNavigationItem(Icons.home, 0),
                    ),
                    Expanded(
                      child: _buildNavigationItem(Icons.bluetooth, 1, isCenter: true),
                    ),
                    Expanded(
                      child: _buildNavigationItem(Icons.library_music, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const MiniPlayer(),
      ],
    );
  }

  Widget _buildNavigationItem(IconData icon, int index, {bool isCenter = false}) {
    return GestureDetector(
      onTap: () {
        _controller.currentIndex.value = index;
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: isCenter
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: _controller.currentIndex.value == index
                    ? CustomColors.blueColor
                    : Colors.transparent,
              )
            : null,
        child: Icon(
          icon,
          color: _controller.currentIndex.value == index
              ? CustomColors.whiteText
              : Colors.grey,
          size: isCenter ? 48 : 36,
        ),
      ),
    );
  }
}
