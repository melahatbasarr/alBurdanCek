import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/features/settings/update_password/repository/update_password_repository.dart';

final class UpdatePasswordController extends GetxController {
  final UpdatePasswordRepository _repository;
  UpdatePasswordController(this._repository);

  late UpdatePasswordDelegate delegate;
  var isLoading = false.obs;

  Future<void> updatePassword({required String oldPassword, required String newPassword}) async {
    isLoading.value = true;
    final result = await _repository.updatePassword(oldPassword: oldPassword, newPassword: newPassword);
    if(result.data == true){
      delegate.notify(true);
    } else if(result.error != null){
      CustomWidgets.showSnackBar(message: result.error!.message);
      delegate.notify(false);
    }
    isLoading.value = false;
  }

}

mixin UpdatePasswordDelegate {
  void notify(bool isSuccess);
}