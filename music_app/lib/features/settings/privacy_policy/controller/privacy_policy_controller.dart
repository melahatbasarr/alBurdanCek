import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/features/settings/privacy_policy/repository/privacy_policy_repository.dart';

final class PrivacyPolicyController extends GetxController {
  final PrivacyPolicyRepository _repository;
  PrivacyPolicyController(this._repository);

  var isLoading = false.obs;
  var agreement = "".obs;

  Future<void> getAgreement() async {
    isLoading.value = true;
    final result = await _repository.getAgreement();
    if(result.data != null){
      agreement.value = result.data!;
    } else if(result.error != null){
     CustomWidgets.showSnackBar(message: result.error!.message);
    }
    isLoading.value = false;
  }

}