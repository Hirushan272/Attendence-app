import 'dart:convert' as convert;
import 'dart:convert';
import 'package:attendance_app/models/employee.dart';
import 'package:attendance_app/models/user.dart';
import 'package:attendance_app/service/leave.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'key_service.dart';

User? userData = User();
Employee? employeeData = Employee();
String? userToken;
String? statusOfUser;
String? base = KeyService.baseUrl;
Future<String?> logIn(String username, String password) async {
  var url = Uri.parse(
      'https://attendance-app-jxyi9.ondigitalocean.app/apiv1.0/users/login');

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

Future<String?>? getStatus(String? empNo) async {
  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(now);
    String finalDate = formattedDate;
    return finalDate;
  }

  final queryParams = {
    "emp_no": empNo.toString(),
    "date": getDate(),
  };

  var url2 = Uri.https("attendance-app-jxyi9.ondigitalocean.app",
      "/apiv1.0/employees/status", queryParams);

  var response = await http.get(
    url2,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "bearer $userToken",
    },
  ).catchError((error) {
    print("Error");
  });

  if (response.statusCode == 200) {
    print(response.body);
    statusOfUser = response.body.toString();
    return response.body.toString();
  } else {}
}

Future<void> logOut() async {
  var url = Uri.parse('${base}apiv1.0/users/logout');
}

Future<void> getEmployeeData() async {
  String empNo = userData!.empNo.toString();
  var url = Uri.parse('${base}apiv1.0/employees/$empNo');

  var response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "bearer $userToken",
    },
  ).catchError((error) {
    print("Error --- ${error.toString()}");
  });

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    employeeData = Employee.fromMap(jsonResponse);
  } else {}
}
