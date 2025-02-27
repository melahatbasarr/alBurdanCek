import 'dart:ui';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/core/resources/data_state.dart';
import 'package:music_app/features/auth/username/repository/username_repository.dart';

final class UsernameController extends GetxController {
  var isLoading = false.obs;

  final UsernameRepository usernameRepository;

  UsernameController({required this.usernameRepository});

  void checkUsername({
    required String username,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () async {
      isLoading.value = false;

      if (username.isNotEmpty) {
        final result =
            await usernameRepository.checkUsername(username: username);

        if (result is DataSuccess<bool>) {
          onSuccess();
        } else if (result.error != null) {
          CustomWidgets.showSnackBar(message: result.error!.message);
        }
      } else {
        CustomWidgets.showSnackBar(message: "Kullanıcı Adını Boş Bırakma.");
      }
    });
  }
}
