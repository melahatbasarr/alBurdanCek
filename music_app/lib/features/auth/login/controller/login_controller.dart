import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/resources/data_state.dart';
import 'package:music_app/features/auth/login/repository/login_repository.dart';
import 'package:music_app/features/navigator/screens/navigator_page.dart';
import 'package:music_app/common/widget/custom_widget.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  final LoginRepository loginRepository;

  // Constructor ile Repository'yi enjekte ediyoruz.
  LoginController({required this.loginRepository});

  void checkFields() {
    if (emailController.text.isEmpty) {
      CustomWidgets.showSnackBar(message: "E-posta adresinizi giriniz");
    } else if (passwordController.text.isEmpty) {
      CustomWidgets.showSnackBar(message: "Şifrenizi giriniz");
    } else {
      loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  Future<void> loginUser({required String email, required String password}) async {
    try {
      isLoading.value = true;

      // Repository'deki loginUser metodunu çağırıyoruz
      final result = await loginRepository.loginUser(email: email, password: password);

      if (result is DataSuccess<String>) {
        // Giriş başarılı, token ile bir işlem yapabilirsiniz.
        CustomWidgets.showSnackBar(message: "Giriş başarılı");
        Get.offAll(() => const NavigatorPage());
      } else if (result is DataFailed) {
        // Hata mesajını kullanıcıya gösteriyoruz.
        CustomWidgets.showSnackBar(message: result.error.toString());
      }
    } catch (e) {
      CustomWidgets.showSnackBar(message: "Bir hata oluştu: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
