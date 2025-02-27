import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/constants.dart';

final class HttpService {
  final String _baseUrl = baseAPIUrl;
  static const String siteUrl = baseAPIUrl;
  String _token = "";

  Future<http.Response> getData({required String apiUrl}) async {
    var url = Uri.parse('$_baseUrl$apiUrl');
    await getToken();
    var header = _header();
    return await http.get(url, headers: header);
  }

  Future<http.Response> postData({required Map<String, dynamic> data, required String apiUrl}) async {
    var url = Uri.parse('$_baseUrl$apiUrl');
    await getToken();
    var header = _header();
    return await http.post(url, body: jsonEncode(data), headers: header);
  }

  Future<http.Response> postFile({required Map<String, String> data, required String apiUrl, required String filepath, required String fileName}) async {
    var url = Uri.parse('$_baseUrl$apiUrl');
    await getToken();
    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    http.MultipartRequest request = http.MultipartRequest('POST', url)
      ..fields.addAll(data)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath(fileName, filepath));
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Map<String, String> _header() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  };

  Future<void> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString("token") ?? "";
  }
}