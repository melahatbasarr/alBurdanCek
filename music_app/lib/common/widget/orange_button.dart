import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';

final class OrangeButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const OrangeButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          constraints: const BoxConstraints(
            minHeight: 55,
          ),
          decoration: BoxDecoration(
            color: CustomColors.orangeText,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins-bold',
                fontWeight: FontWeight.bold,
                color: CustomColors.darkGreyColor,
              ))),
    );
  }
}
