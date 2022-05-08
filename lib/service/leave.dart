import 'package:attendance_app/models/leave.dart';
import 'package:attendance_app/models/responce_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';

class Leave {
  String getDate(String? date) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    var date1 = inputFormat.parse(date!);

    var outputFormat = DateFormat('yyyy-MM-dd');
    var date2 = outputFormat.format(date1);
    return date2;
  }

  Future<ResponseModel> submitLeave(LeaveModel leave) async {
    var url = Uri.parse('https://attendace-api.herokuapp.com/apiv1.0/leaves');
    String? message;
    var response = await http
        .post(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'emp_no': leave.empNo!,
              'leave_type_id': leave.leaveTypeId!,
              'apply_date': getDate(leave.applyDate!),
              'leave_date': getDate(leave.leaveDate!),
              'day_type_id': leave.dayTypeId!,
              'leave_qty': leave.leaveQty!,
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
          message = "Authentication failed.";
          responseModel.statusCode == 401;
          responseModel.message = message;
          break;
        default:
          message = "Authentication failed!";
          responseModel.statusCode == response.statusCode;
          responseModel.message = message;
          break;
      }
      print('Request failed with status: ${response.statusCode}.');
      return responseModel;
    }
  }

  Future<void> cancelLeaves(LeaveModel? leave) async {
    var url =
        Uri.parse('https://attendace-api.herokuapp.com/apiv1.0/leaves/cancel');

    var response = await http
        .put(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'emp_no': leave!.empNo!,
              'leave_type_id': leave.leaveTypeId!,
              'leave_date': getDate(leave.leaveDate!),
              'cancelRemark': 'cancel'
            }))
        .catchError((error) {
      print("Error");
    });
  }
}
