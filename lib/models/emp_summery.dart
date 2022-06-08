import 'dart:convert';

class EmpSummery {
  String? leaveType;
  int? isPaid;
  int? leaveBalance;
  int? usedLeaves;
  int? rejectedLeaves;
  EmpSummery({
    this.leaveType,
    this.isPaid,
    this.leaveBalance,
    this.usedLeaves,
    this.rejectedLeaves,
  });

  EmpSummery copyWith({
    String? leaveType,
    int? isPaid,
    int? leaveBalance,
    int? usedLeaves,
    int? rejectedLeaves,
  }) {
    return EmpSummery(
      leaveType: leaveType ?? this.leaveType,
      isPaid: isPaid ?? this.isPaid,
      leaveBalance: leaveBalance ?? this.leaveBalance,
      usedLeaves: usedLeaves ?? this.usedLeaves,
      rejectedLeaves: rejectedLeaves ?? this.rejectedLeaves,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'leave_type': leaveType,
      'is_paid': isPaid,
      'leave_balance': leaveBalance,
      'used_leaves': usedLeaves,
      'rejected_leaves': rejectedLeaves,
    };
  }

  factory EmpSummery.fromMap(Map<String, dynamic> map) {
    return EmpSummery(
      leaveType: map['leave_type'],
      isPaid: map['is_paid']?.toInt(),
      leaveBalance: map['leave_balance']?.toInt(),
      usedLeaves: map['used_leaves']?.toInt(),
      rejectedLeaves: map['rejected_leaves']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpSummery.fromJson(String source) =>
      EmpSummery.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmpSummery(leaveType: $leaveType, isPaid: $isPaid, leaveBalance: $leaveBalance, usedLeaves: $usedLeaves, rejectedLeaves: $rejectedLeaves)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmpSummery &&
        other.leaveType == leaveType &&
        other.isPaid == isPaid &&
        other.leaveBalance == leaveBalance &&
        other.usedLeaves == usedLeaves &&
        other.rejectedLeaves == rejectedLeaves;
  }

  @override
  int get hashCode {
    return leaveType.hashCode ^
        isPaid.hashCode ^
        leaveBalance.hashCode ^
        usedLeaves.hashCode ^
        rejectedLeaves.hashCode;
  }
}
