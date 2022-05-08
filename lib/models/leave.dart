import 'dart:convert';

class LeaveModel {
  String? empNo;
  String? leaveTypeId;
  String? applyDate;
  String? leaveDate;
  String? dayTypeId;
  String? leaveQty;
  String? remark;
  LeaveModel({
    this.empNo,
    this.leaveTypeId,
    this.applyDate,
    this.leaveDate,
    this.dayTypeId,
    this.leaveQty,
    this.remark,
  });

  LeaveModel copyWith({
    String? empNo,
    String? leaveTypeId,
    String? applyDate,
    String? leaveDate,
    String? dayTypeId,
    String? leaveQty,
    String? remark,
  }) {
    return LeaveModel(
      empNo: empNo ?? this.empNo,
      leaveTypeId: leaveTypeId ?? this.leaveTypeId,
      applyDate: applyDate ?? this.applyDate,
      leaveDate: leaveDate ?? this.leaveDate,
      dayTypeId: dayTypeId ?? this.dayTypeId,
      leaveQty: leaveQty ?? this.leaveQty,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'empNo': empNo,
      'leaveTypeId': leaveTypeId,
      'applyDate': applyDate,
      'leaveDate': leaveDate,
      'dayTypeId': dayTypeId,
      'leaveQty': leaveQty,
      'remark': remark,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      empNo: map['empNo'],
      leaveTypeId: map['leaveTypeId'],
      applyDate: map['applyDate'],
      leaveDate: map['leaveDate'],
      dayTypeId: map['dayTypeId'],
      leaveQty: map['leaveQty'],
      remark: map['remark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveModel.fromJson(String source) =>
      LeaveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Leave(empNo: $empNo, leaveTypeId: $leaveTypeId, applyDate: $applyDate, leaveDate: $leaveDate, dayTypeId: $dayTypeId, leaveQty: $leaveQty, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LeaveModel &&
        other.empNo == empNo &&
        other.leaveTypeId == leaveTypeId &&
        other.applyDate == applyDate &&
        other.leaveDate == leaveDate &&
        other.dayTypeId == dayTypeId &&
        other.leaveQty == leaveQty &&
        other.remark == remark;
  }

  @override
  int get hashCode {
    return empNo.hashCode ^
        leaveTypeId.hashCode ^
        applyDate.hashCode ^
        leaveDate.hashCode ^
        dayTypeId.hashCode ^
        leaveQty.hashCode ^
        remark.hashCode;
  }
}
