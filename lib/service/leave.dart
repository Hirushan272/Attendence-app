import 'package:attendance_app/models/emp_summery.dart';
import 'package:attendance_app/models/employee.dart';
import 'package:attendance_app/models/leave.dart';
import 'package:attendance_app/models/responce_model.dart';
import 'package:attendance_app/service/key_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';

import 'auth_service.dart';

// String base = "https://attendance-app-jxyi9.ondigitalocean.app";

class Leave {
  String? base = KeyService.baseUrl;
  LeaveModel leaveModel = LeaveModel();
  static List<EmpSummery> empSummeryList = [];
  String getDate(String? date) {
    // print(date);
    // var inputFormat = DateFormat('yyyy/MM/dd');
    // var date1 = inputFormat.parse(date!);

    // var outputFormat = DateFormat('yyyy-MM-dd');
    // var date2 = outputFormat.format(date1);
    // print(date2);
    return date!;
  }

  Future<ResponseModel> submitLeave(LeaveModel leave) async {
    var url = Uri.parse('${base}apiv1.0/leaves');
    String? message;
    var response = await http
        .post(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              // "Authorization": "bearer $userToken",
            },
            body: convert.jsonEncode(<String, dynamic>{
              'emp_no': leave.empNo!,
              'leave_type_id': leave.leaveTypeId!,
              'apply_date': getDate(leave.applyDate!),
              'leave_date': getDate(leave.leaveDate!),
              'day_type_id': leave.dayTypeId,
              'leave_qty': leave.leaveQty,
              'remark': leave.remark!,
            }))
        .catchError((error) {
      print("Error");
    });
    ResponseModel responseModel = ResponseModel();
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      responseModel.statusCode == 200;
      responseModel.message = jsonResponse.toString();
      return responseModel;
    } else {
      switch (response.statusCode) {
        case 400:
          var errorMsg = convert.jsonDecode(response.body) as String;
          message = errorMsg;
          responseModel.statusCode == 400;
          responseModel.message = message;
          break;
        case 401:
          message = "Leave submission failed!";
          responseModel.statusCode == 401;
          responseModel.message = message;
          break;
        case 524:
          message = "Connection timeout!";
          responseModel.statusCode == 524;
          responseModel.message = message;
          break;
        default:
          message = "Leave submission failed!";
          responseModel.statusCode == response.statusCode;
          responseModel.message = message;
          break;
      }
      print('Request failed with status: ${response.statusCode}.');
      return responseModel;
    }
  }

  Future<String?> cancelLeaves(LeaveModel? leave) async {
    var url = Uri.parse('${base}apiv1.0/leaves/cancel');

    var response = await http
        .put(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'emp_no': leave!.empNo.toString(),
              'leave_type_id': leave.leaveTypeId!,
              'leave_date': getDate(leave.leaveDate!),
              'cancelRemark': 'cancel'
            }))
        .catchError((error) {
      print("Error");
    });

    if (response.statusCode == 200) {
      return "ok";
    } else {
      return "off";
    }
  }

  static List<LeaveModel> empLeaveList = [];

  Future<String?> getEmpLeaveData(String? empNo) async {
    print("object 1");
    empLeaveList = [];
    var url = Uri.parse('${base}apiv1.0/leaves/emp_no/$empNo');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "bearer $userToken",
      },
    ).catchError((error) {
      print("Error --- ${error.toString()}");
    });
    print("object 2 ${response.statusCode}");
    if (response.statusCode == 200) {
      print("object 3");
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      print("HHHH ${jsonResponse.toString()}");
      // leaveModel = LeaveModel.fromMap(jsonResponse);
      if (jsonResponse.isNotEmpty) {
        for (var e in jsonResponse) {
          empLeaveList.add(LeaveModel.fromMap(e));
        }
      }
      print(empLeaveList.length);
      return "ok";
    } else {
      print("object 5");
    }
  }

  Future<void> getEmpDataCurrantMonth() async {
    print("object 11");
    // final queryParams = {
    var empNo = userData?.empNo;
    var month = DateTime.now().month;
    // };
    var url = Uri.parse(
        "${base}apiv1.0/leaves/monthly-summary/?emp_no=$empNo&month=$month");
    print("object 22");
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "bearer $userToken",
      },
    ).catchError((error) {
      print("Error --- ${error.toString()}");
    });
    print("object 33");
    if (response.statusCode == 200) {
      print("object 3");
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      print("HHHH ${jsonResponse.toString()}");

      if (jsonResponse.isNotEmpty) {
        for (var e in jsonResponse) {
          empSummeryList.add(EmpSummery.fromMap(e));
        }
      }
      print(empSummeryList.length);
      // return "ok";
    } else {
      print("object 5");
    }
  }
}
