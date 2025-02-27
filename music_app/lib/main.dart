import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/features/auth/username/controller/username_controller.dart';
import 'package:music_app/features/auth/username/repository/username_repository.dart';
import 'package:provider/provider.dart';
import 'package:music_app/features/auth/login/controller/login_controller.dart';
import 'package:music_app/features/auth/login/repository/login_repository.dart';
import 'package:music_app/features/auth/register/controller/register_controller.dart';
import 'package:music_app/features/auth/register/repository/register_repository.dart';
import 'package:music_app/features/settings/update_profile/controller/update_profile_controller.dart';
import 'package:music_app/features/onboarding/onboarding_page.dart';

void main() {
  // GetX bağımlılıkları başlatılıyor
  final loginRepository = LoginRepositoryImpl();
  final registerRepository = RegisterRepositoryImpl();
  final usernameRepository = UserNameRepositoryImpl();

  Get.lazyPut<LoginController>(
      () => LoginController(loginRepository: loginRepository));
  Get.lazyPut<RegisterController>(
      () => RegisterController(registerRepository: registerRepository));
  Get.lazyPut<UsernameController>(
      () => UsernameController(usernameRepository: usernameRepository));

  // Uygulamayı başlatma
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdateProfileController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: "Poppins Medium",
      ),
      home: const OnBoardingPage(),
    );
  }
}
