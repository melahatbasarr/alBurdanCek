import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';

class LoadingAnimation extends StatelessWidget {
  final bool isLoading;
  const LoadingAnimation({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: const Center(
          child: CircularProgressIndicator(
            color: CustomColors.whiteText,
          ),
        ),
      ),
    );
  }
}
