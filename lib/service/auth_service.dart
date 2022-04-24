import 'dart:convert' as convert;
import 'dart:convert';
import 'package:attendance_app/models/employee.dart';
import 'package:http/http.dart' as http;

User? userData = User();
String? userToken;
Future<String?> logIn(String username, String password) async {
  var url = Uri.parse('http://157.230.47.27:3000/apiv1.0/users/login');

  String? message;
  var response = await http
      .post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": username,
            "password_hash": password,
          }))
      .catchError((error) {
    print("Error");
  });

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    userData = User.fromMap(jsonResponse["user"]);
    userToken = jsonResponse["token"];
    return "ok";
  } else {
    switch (response.statusCode) {
      case 400:
        var errorMsg = convert.jsonDecode(response.body) as String;
        message = errorMsg;
        break;
      case 401:
        message = "Authentication failed.";
        break;
      default:
        message = "Authentication failed!";
        break;
    }
    print('Request failed with status: ${response.statusCode}.');
    return message;
  }
}

Future<void> logOut() async {
  var url = Uri.parse('http://157.230.47.27:3000/apiv1.0/users/logout');
}
