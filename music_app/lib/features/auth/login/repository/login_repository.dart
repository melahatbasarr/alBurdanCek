import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/common/controller/user_controller.dart';
import 'package:music_app/common/model/user_model.dart';
import 'package:music_app/services/http_service.dart';

import '../../../../core/resources/data_state.dart';

abstract class LoginRepository {
  Future<DataState<String>> loginUser({required String email, required String password});
  Future<DataState<bool>> getUserInfo({required String token});
}

final class LoginRepositoryImpl extends LoginRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<String>> loginUser({required String email, required String password}) async {
    try {
      final data = {
        "email": email,
        "password": password
      };
      final res = await _service.postData(data: data, apiUrl: "/login");
      final body = json.decode(res.body);
      
      if(body["success"] == "true"){
        return DataSuccess(body["token"]);
      }
      return DataFailed(FlutterError("Giriş bilgilerinizi kontrol ediniz"));
    } catch(error) {
      return DataFailed(FlutterError("Giriş bilgilerinizi kontrol ediniz"));
    }
  }

  @override
  Future<DataState<bool>> getUserInfo({required String token}) async {
    try {
      final res = await _service.getData(apiUrl: "/getUserInfo");
      final body = json.decode(res.body);
      if(body["success"] == "true"){
        final UserModel model = UserModel.fromJson(body["data"]);
        UserController.setUserInfo(model);
        return const DataSuccess(true);
      }
      return DataFailed(FlutterError(""));
    } catch(error) {
      return DataFailed(FlutterError(""));
    }
  }

} 