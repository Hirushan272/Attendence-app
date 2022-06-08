import 'dart:convert';

class LeaveModel {
  String? empNo;
  String? leaveTypeId;
  String? applyDate;
  String? leaveDate;
  String? dayTypeId;
  int? leaveQty;
  String? remark;
  int? isApproved;
  String? cancelRemark;
  LeaveModel(
      {this.empNo,
      this.leaveTypeId,
      this.applyDate,
      this.leaveDate,
      this.dayTypeId,
      this.leaveQty,
      this.remark,
      this.isApproved,
      this.cancelRemark});

  LeaveModel copyWith(
      {String? empNo,
      String? leaveTypeId,
      String? applyDate,
      String? leaveDate,
      String? dayTypeId,
      int? leaveQty,
      String? remark,
      int? isApproved,
      String? cancelRemark}) {
    return LeaveModel(
        empNo: empNo ?? this.empNo,
        leaveTypeId: leaveTypeId ?? this.leaveTypeId,
        applyDate: applyDate ?? this.applyDate,
        leaveDate: leaveDate ?? this.leaveDate,
        dayTypeId: dayTypeId ?? this.dayTypeId,
        leaveQty: leaveQty ?? this.leaveQty,
        remark: remark ?? this.remark,
        isApproved: isApproved ?? this.isApproved,
        cancelRemark: cancelRemark ?? this.cancelRemark);
  }

  Map<String, dynamic> toMap() {
    return {
      'emp_no': empNo,
      'leave_type_id': leaveTypeId,
      'apply_date': applyDate,
      'leave_date': leaveDate,
      'day_type_id': dayTypeId,
      'leave_qty': leaveQty,
      'remark': remark,
      'is_approved': isApproved,
      'cancel_remark': cancelRemark
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
        empNo: map['emp_no'],
        leaveTypeId: map['leave_type_id'],
        applyDate: map['apply_date'],
        leaveDate: map['leave_date'],
        dayTypeId: map['day_type_id'],
        leaveQty: map['leave_qty'],
        remark: map['remark'],
        isApproved: map['is_approved'],
        cancelRemark: map['cancel_remark']);
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
