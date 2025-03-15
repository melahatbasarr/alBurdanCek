import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';

class MailVerificationController extends GetxController {
  final isLoading = false.obs;
  final isVerified = false.obs;

  // Mock function to send verification code
  Future<void> sendVerificationCode(String email) async {
    try {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // If successful
      CustomWidgets.showSnackBar(message: "Verification code sent to your email");
    } catch (e) {
      CustomWidgets.showSnackBar(message: "Failed to send verification code: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // Mock function to verify the code
  Future<bool> verifyCode(String code) async {
    try {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, let's say any 6-digit code is valid
      if (code.length == 6 && int.tryParse(code) != null) {
        isVerified.value = true;
        CustomWidgets.showSnackBar(message: "Email verified successfully");
        return true;
      } else {
        CustomWidgets.showSnackBar(message: "Invalid verification code");
        return false;
      }
    } catch (e) {
      CustomWidgets.showSnackBar(message: "Verification failed: ${e.toString()}");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
} 