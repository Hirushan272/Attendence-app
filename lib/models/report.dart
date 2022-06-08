import 'dart:convert';

class MonthlyReport {
  int? workMinutesMonth;
  int? leaveMinutesMonth;
  int? singleOtMinutes;
  int? doubleOtMinutes;
  int? tripleOtMinutes;
  String? message;
  int? statusCode;
  MonthlyReport({
    this.workMinutesMonth,
    this.leaveMinutesMonth,
    this.singleOtMinutes,
    this.doubleOtMinutes,
    this.tripleOtMinutes,
    this.message,
    this.statusCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'workMinutesMonth': workMinutesMonth,
      'leaveMinutesMonth': leaveMinutesMonth,
      'singleOt_minutesTotal': singleOtMinutes,
      'doubleOt_minutesTotal': doubleOtMinutes,
      'tripleOt_minutesTotal': tripleOtMinutes,
      'message': message,
      'statusCode': statusCode,
    };
  }

  factory MonthlyReport.fromMap(Map<String, dynamic> map) {
    return MonthlyReport(
      workMinutesMonth: map['workMinutesMonth']?.toInt(),
      leaveMinutesMonth: map['leaveMinutesMonth']?.toInt(),
      singleOtMinutes: map['singleOt_minutesTotal']?.toInt(),
      doubleOtMinutes: map['doubleOt_minutesTotal']?.toInt(),
      tripleOtMinutes: map['tripleOt_minutesTotal']?.toInt(),
      message: map['message'],
      statusCode: map['statusCode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthlyReport.fromJson(String source) =>
      MonthlyReport.fromMap(json.decode(source));

  MonthlyReport copyWith({
    int? workMinutesMonth,
    int? leaveMinutesMonth,
    int? singleOtMinutes,
    int? doubleOtMinutes,
    int? tripleOtMinutes,
    String? message,
    int? statusCode,
  }) {
    return MonthlyReport(
      workMinutesMonth: workMinutesMonth ?? this.workMinutesMonth,
      leaveMinutesMonth: leaveMinutesMonth ?? this.leaveMinutesMonth,
      singleOtMinutes: singleOtMinutes ?? this.singleOtMinutes,
      doubleOtMinutes: doubleOtMinutes ?? this.doubleOtMinutes,
      tripleOtMinutes: tripleOtMinutes ?? this.tripleOtMinutes,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  String toString() {
    return 'MonthlyReport(workMinutesMonth: $workMinutesMonth, leaveMinutesMonth: $leaveMinutesMonth, singleOtMinutes: $singleOtMinutes, doubleOtMinutes: $doubleOtMinutes, tripleOtMinutes: $tripleOtMinutes, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MonthlyReport &&
        other.workMinutesMonth == workMinutesMonth &&
        other.leaveMinutesMonth == leaveMinutesMonth &&
        other.singleOtMinutes == singleOtMinutes &&
        other.doubleOtMinutes == doubleOtMinutes &&
        other.tripleOtMinutes == tripleOtMinutes &&
        other.message == message &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return workMinutesMonth.hashCode ^
        leaveMinutesMonth.hashCode ^
        singleOtMinutes.hashCode ^
        doubleOtMinutes.hashCode ^
        tripleOtMinutes.hashCode ^
        message.hashCode ^
        statusCode.hashCode;
  }
}
