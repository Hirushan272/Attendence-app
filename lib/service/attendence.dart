import 'dart:convert' as convert;
import 'dart:convert';

import 'package:attendance_app/models/attendance.dart';
import 'package:attendance_app/models/employee.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AttendanceResponse {
  String? statusCode;
  String? messages;
  AttendanceResponse({
    this.statusCode,
    this.messages,
  });
}

class AttendanceService {
  Future<AttendanceResponse?> attendance(
      Attendance attendance, String? token) async {
    var url = Uri.parse("http://157.230.47.27:3000/apiv1.0/attendance");

    AttendanceResponse res = AttendanceResponse();
    print(userToken);
    String? message;
    print("${attendance.fPrint?.direction}");
    Response response = await http
        .post(url,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "Authorization": "bearer $token",
            },
            body: jsonEncode({
              "emp_no": attendance.empNo,
              "date": attendance.date,
              "fprints": attendance.fPrint?.toMap(),
            }))
        .catchError((error) {
      print("Error");
    });
    res.statusCode = response.statusCode.toString();

    if (response.statusCode == 200) {
      var jsonResponse = response.body.toString();
      // User user = User.fromMap(jsonResponse["user"]);
      res.messages = jsonResponse;

      return res;
    } else {
      switch (response.statusCode) {
        case 400:
          var errorMsg = response.body.toString();
          res.messages = errorMsg;
          break;
        case 401:
          res.messages = "Authentication failed.";
          break;
        default:
          res.messages = "Authentication failed!";
          break;
      }
      print('Request failed with status: ${response.statusCode}.');
      return res;
    }
  }
}
