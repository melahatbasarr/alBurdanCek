import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:music_app/services/http_service.dart';
import '../../../../core/resources/data_state.dart';

abstract class PrivacyPolicyRepository {
  Future<DataState<String>> getAgreement();
}

final class PrivacyPolicyRepositoryImpl extends PrivacyPolicyRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<String>> getAgreement() async {
    try {
      final res = await _service.getData(apiUrl: "/getAgreements");
      final body = json.decode(res.body);
      print("agreement body : $body");
      final String agreement = body["data"];
      return DataSuccess(agreement);
    } catch (error) {
      return DataFailed(FlutterError("Failed to upload confidentiality agreement"));
    }
  }

}