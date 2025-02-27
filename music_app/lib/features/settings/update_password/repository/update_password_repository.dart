import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:music_app/services/http_service.dart';
import '../../../../core/resources/data_state.dart';

abstract class UpdatePasswordRepository {
  Future<DataState<bool>> updatePassword({required String oldPassword, required String newPassword});
}

final class UpdatePasswordRepositoryImpl extends UpdatePasswordRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> updatePassword({required String oldPassword, required String newPassword}) async {
    try {
      final data = {
        "old_password": oldPassword,
        "password": newPassword,
      };
      final res = await _service.postData(data: data, apiUrl: "/updatePassword");
      final body = json.decode(res.body);
      if(body["success"] == "true"){
        return const DataSuccess(true);
      } else {
        if(body["error"] == "old_password_wrong") {
          return DataFailed(FlutterError("Check your old password"));
        }
        return DataFailed(FlutterError("Your password could not be updated"));
      }
    } catch(error) {
      return DataFailed(FlutterError("Your password could not be updated"));
    }
  }

}