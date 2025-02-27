import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:music_app/common/controller/user_controller.dart';
import 'package:music_app/services/http_service.dart';
import '../../../../core/resources/data_state.dart';

abstract class DeleteAccountRepository {
  Future<DataState<bool>> sendDeleteRequest({required String message});
}

final class DeleteAccountRepositoryImpl extends DeleteAccountRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> sendDeleteRequest({required String message}) async {
    try {
      final data = {
        "user_id": UserController.id,
        "message": message
      };
      final res = await _service.postData(data: data, apiUrl: "/createAccountDeleteRequest");
      final body = json.decode(res.body);
      if(body["success"]=="true"){
        return const DataSuccess(true);
      }
      return DataFailed(FlutterError("Your deletion request could not be sent"));
    } catch(error) {
      return DataFailed(FlutterError("Your deletion request could not be sent"));
    }
  }

}