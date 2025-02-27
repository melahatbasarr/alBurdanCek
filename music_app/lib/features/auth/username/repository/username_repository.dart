import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/core/resources/data_state.dart';
import 'package:music_app/services/http_service.dart';

abstract class UsernameRepository {
  Future<DataState<bool>> checkUsername({required String username});
}

final class UserNameRepositoryImpl extends UsernameRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> checkUsername({required String username}) async {
    try {
      final data = {
        "username": username,
      };

      final res =
          await _service.postData(data: data, apiUrl: "/check-username");
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
