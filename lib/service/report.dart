import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:attendance_app/models/attendance.dart';
import 'package:attendance_app/models/employee.dart';
import 'package:attendance_app/pages/Home/report_data.dart';
import 'package:attendance_app/service/auth_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:attendance_app/models/report.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

Future<MonthlyReport?> getReport(
  String? empNo,
  int? month,
  int? year,
) async {
  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(now);
    String finalDate = "$formattedDate 8:30:00.000";
    return finalDate;
  }

  MonthlyReport mtr = MonthlyReport();
  var url1 =
      Uri.parse("http://157.230.47.27:3000/apiv1.0/attendance/daily-summary");
  var url2 =
      Uri.parse("http://157.230.47.27:3000/apiv1.0/attendance/monthly-summary");

  print(userToken);
  String? message;
  Response response1 = await http
      .put(url1,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "bearer $userToken",
          },
          body: jsonEncode({
            "emp_no": empNo,
            "date": getDate(),
            "month": month,
            "year": year
          }))
      .catchError((error) {
    print("Error");
  });

  Response response2 = await http
      .put(url2,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "bearer $userToken",
          },
          body: jsonEncode({
            "emp_no": empNo,
            "date": getDate(),
            "month": month,
            "year": year
          }))
      .catchError((error) {
    print("Error");
  });
  // res.statusCode = response.statusCode.toString();
  mtr.statusCode = response2.statusCode;
  if (response2.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response2.body);
    // User user = User.fromMap(jsonResponse["user"]);
    // mtr.message = jsonResponse['message'];

    mtr.workMinutesMonth = jsonResponse["workMinutesMonth"];
    mtr.leaveMinutesMonth = jsonResponse["leaveMinutesMonth"];

    return mtr;
  } else {
    switch (response2.statusCode) {
      case 400:
        var errorMsg = response2.body.toString();
        mtr.message = errorMsg;
        break;
      case 401:
        mtr.message = "Authentication failed.";
        break;
      default:
        mtr.message = "Authentication failed!";
        break;
    }
    print('Request failed with status: ${response2.statusCode}.');
    return mtr;
  }
}

List<Placemark?> placemark = [];
Future<String?> getPlaceMark(double? lat, double? long) async {
  placemark = [];
  placemark = await placemarkFromCoordinates(lat!, long!);
  return placemark[0]?.locality;
}

Future<LogData?>? getLog(String? empNo) async {
  LogData logData = LogData();
  List<LogModel> logList = [];
  var url = Uri.parse(
    "http://157.230.47.27:3000/apiv1.0/attendance/$empNo",
  );

  http.Response response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "bearer $userToken",
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);

    logData.date = jsonResponse["date"].toString().substring(0, 10);
    var data = jsonResponse["fprints"] as List<dynamic>;
    for (var e in data) {
      LogModel logModel = LogModel();
      logModel.status = e["direction"];
      logModel.time = e["time"];
      logModel.lat = e["location"]["lat"];
      logModel.long = e["location"]["long"];
      logModel.place = await getPlaceMark(logModel.lat, logModel.long);
      logList.add(logModel);
    }
    logData.logList = logList;
  }
  return logData;
}
