import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:music_app/config/theme/custom_colors.dart';

final class CustomWidgets {
  static Text pageTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: CustomColors.orangeText,
        fontSize: 35,
        fontFamily: "Poppins-Bold",
      ),
    );
  }

  static Text title(
    String title, {
    Color color = CustomColors.whiteText,
    bool underline = false, 
  }) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 19,
        fontFamily: "Poppins-bold",
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  static AppBar appBar(String title, {bool? backButtonVisibility}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontFamily: "Poppins-bold",
        ),
      ),
      centerTitle: true,
      leading: Visibility(
        visible: backButtonVisibility ?? true,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: CustomColors.darkGreyColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: CustomColors.orangeText,
                  width: 1,
                )),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }

  static showSnackBar({String? title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: CustomColors.orangeText,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
