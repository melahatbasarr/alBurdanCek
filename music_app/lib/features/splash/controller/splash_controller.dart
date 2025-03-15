import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:music_app/features/onboarding/onboarding_page.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    
    // Animasyon controller'ı başlat
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    // Fade-in ve scale animasyonları oluştur
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );
    
    // Animasyonu başlat
    animationController.forward();
    
    // 2.5 saniye sonra onboarding ekranına yönlendir
    Future.delayed(const Duration(milliseconds: 2500), () {
      navigateToOnboarding();
    });
  }
  
  void navigateToOnboarding() {
    Get.off(() => const OnBoardingPage(), transition: Transition.fadeIn);
  }
  
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
