import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/splash/controller/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Pulse animasyonunu tekrarlı olarak başlat
    _pulseController.repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SplashController'ı başlat
    final controller = Get.put(SplashController());
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      body: Center(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Animasyonu
                Opacity(
                  opacity: controller.fadeAnimation.value,
                  child: Transform.scale(
                    scale: controller.scaleAnimation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Pulsating circle
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: size.width * 0.55,
                                height: size.width * 0.55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: CustomColors.orangeText.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // Logo container
                        Container(
                          width: size.width * 0.5,
                          height: size.width * 0.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.orangeText.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/icons/bocek.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Uygulama Adı ve Slogan
                Opacity(
                  opacity: controller.fadeAnimation.value,
                  child: Column(
                    children: [
                      const Text(
                        "MÜZİK APP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontFamily: "Poppins Bold",
                        ),
                      ),
                      
                      const SizedBox(height: 10),
                      
                      Text(
                        "Müzik dünyasını keşfedin",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16,
                          fontFamily: "Poppins Medium",
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Yükleniyor İndikatörü
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.orangeText,
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 