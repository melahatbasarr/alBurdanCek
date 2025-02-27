import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/services/http_service.dart';

import '../../../../core/resources/data_state.dart';

abstract class RegisterRepository {
  Future<DataState<bool>> registerUser(
      {required String email, required String password});
}

final class RegisterRepositoryImpl extends RegisterRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> registerUser(
      {required String email, required String password}) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };

      final res = await _service.postData(data: data, apiUrl: "/register");
      final body = json.decode(res.body);

      if (body["success"] == "true") {
        return const DataSuccess(true);
      }

      return DataFailed(FlutterError(body["message"]));
    } catch (error) {
      return DataFailed(FlutterError("error"));
    }
  }
}
