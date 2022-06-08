import 'package:attendance_app/service/auth_service.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class KeyService {
  static String? baseUrl;
  final LocalStorage storage = LocalStorage('some_key');

  Future<String?> getBaseUrl(String shortCode) async {
    String? message;
    var url = Uri.parse(
        'https://attendance-app-jxyi9.ondigitalocean.app/apiv1.0/companies/base_url/$shortCode');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "bearer $userToken",
      },
    ).catchError((error) {
      print("Error --- ${error.toString()}");
    });
    print("URL ${response.statusCode}");

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("HHHH ${jsonResponse.toString()}");
      baseUrl = jsonResponse["base_url"];
      await setValue(baseUrl!);
      message = "ok";
    } else if (response.statusCode == 404) {
      message = "Incorrect short code";
    } else {
      message = "Can't get base url E-${response.statusCode}";
    }
    return message;
  }

  Future<String> setValue(String baseUrl) async {
    print("BASE $baseUrl");
    storage.setItem('base', baseUrl);
    return "ok";
  }

  Future<String?> getValue() async {
    String? val = storage.getItem('base');
    print(val);
    baseUrl = val;
    return val;
  }
}
