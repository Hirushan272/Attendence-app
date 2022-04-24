import 'dart:convert';

import 'package:attendance_app/models/finger_print.dart';

class Attendance {
  String? empNo;
  String? date;
  FingerPrint? fPrint;
  Attendance({
    this.empNo,
    this.date,
    this.fPrint,
  });

  Map<String, dynamic> toMap() {
    return {
      'empNo': empNo,
      'date': date,
      'fPrint': fPrint?.toMap(),
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      empNo: map['empNo'],
      date: map['date'],
      fPrint: map['fPrint'] != null ? FingerPrint.fromMap(map['fPrint']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));
}
