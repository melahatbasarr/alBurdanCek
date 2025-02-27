import 'package:flutter/material.dart';
import 'package:music_app/features/settings/update_profile/model/update_profile_model.dart';

class UpdateProfileController extends ChangeNotifier {
  UpdateProfileModel _user = UpdateProfileModel(
    username: "Tanya Myroniuk",
    email: "tanya.myroniuk@example.com",
    phoneNumber: "+880712663389",
  );

  UpdateProfileModel get user => _user;

  /// Kullanıcı bilgilerini parça parça güncellemek için
  void updateUser({
    String? username,
    String? email,
    String? phoneNumber,
  }) {
    _user = _user.copyWith(
      username: username ?? _user.username,
      email: email ?? _user.email,
      phoneNumber: phoneNumber ?? _user.phoneNumber,
    );
    notifyListeners(); // UI'yi güncellemek için
  }
}
