import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/core/resources/data_state.dart';
import 'package:music_app/features/auth/register/repository/register_repository.dart';

final class RegisterController extends GetxController {
  var isLoading = false.obs;

  final RegisterRepository registerRepository;

  RegisterController({required this.registerRepository});

  void registerUser({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () async {
      isLoading.value = false;

      if (email.isNotEmpty && password.isNotEmpty) {
        final result = await registerRepository.registerUser(
            email: email, password: password);

        if (result is DataSuccess<bool> == true) {
          onSuccess();
        } else if (result.error != null) {
          CustomWidgets.showSnackBar(message: result.error!.message);
        }
      } else {
        CustomWidgets.showSnackBar(message: "Boş bırakma.");
      }
    });
  }
}
