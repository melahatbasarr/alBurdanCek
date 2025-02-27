import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/features/settings/delete_account/repository/delete_account_repository.dart';

final class DeleteAccountController extends GetxController {
  final DeleteAccountRepository _repository;
  DeleteAccountController(this._repository);

  late DeleteAccountDelegate delegate;
  var isLoading = false.obs;

  Future<void> sendDeleteRequest(String message) async {
    final result = await _repository.sendDeleteRequest(message: message);
    if(result.data == true){
      delegate.notify(true);
    } else if(result.error != null) {
      CustomWidgets.showSnackBar(message: result.error!.message);
      delegate.notify(false);
    }
  }
} 

mixin DeleteAccountDelegate {
  void notify(bool isSuccess);
}