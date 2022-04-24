import 'dart:convert';

class MonthlyReport {
  int? workMinutesMonth;
  int? leaveMinutesMonth;
  String? message;
  int? statusCode;
  MonthlyReport({
    this.workMinutesMonth,
    this.leaveMinutesMonth,
    this.message,
    this.statusCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'workMinutesMonth': workMinutesMonth,
      'leaveMinutesMonth': leaveMinutesMonth,
      'message': message,
      'statusCode': statusCode,
    };
  }

  factory MonthlyReport.fromMap(Map<String, dynamic> map) {
    return MonthlyReport(
      workMinutesMonth: map['workMinutesMonth']?.toInt(),
      leaveMinutesMonth: map['leaveMinutesMonth']?.toInt(),
      message: map['message'],
      statusCode: map['statusCode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthlyReport.fromJson(String source) =>
      MonthlyReport.fromMap(json.decode(source));
}
