import 'dart:convert';

class Employee {
  String? empNo;
  String? title;
  String? fullName;
  String? nic;
  String? mobile;
  String? landLine;
  String? email;
  String? addressR;
  String? addressG;
  String? designationId;
  String? occupationalCatId;
  String? employeeType;
  String? startDay;
  String? endDay;
  String? dateOfBirth;
  String? civilStatus;
  String? gender;
  String? ETFNo;
  String? EPFno;
  String? enrollNo;
  int? priorityIndex;
  String? profilePic;
  String? remark;
  int? isActive;
  String? branchId;
  String? departmentId;
  int? mealType;
  Employee({
    this.empNo,
    this.title,
    this.fullName,
    this.nic,
    this.mobile,
    this.landLine,
    this.email,
    this.addressR,
    this.addressG,
    this.designationId,
    this.occupationalCatId,
    this.employeeType,
    this.startDay,
    this.endDay,
    this.dateOfBirth,
    this.civilStatus,
    this.gender,
    this.ETFNo,
    this.EPFno,
    this.enrollNo,
    this.priorityIndex,
    this.profilePic,
    this.remark,
    this.isActive,
    this.branchId,
    this.departmentId,
    this.mealType,
  });

  Employee copyWith({
    String? empNo,
    String? title,
    String? fullName,
    String? nic,
    String? mobile,
    String? landLine,
    String? email,
    String? addressR,
    String? addressG,
    String? designationId,
    String? occupationalCatId,
    String? employeeType,
    String? startDay,
    String? endDay,
    String? dateOfBirth,
    String? civilStatus,
    String? gender,
    String? ETFNo,
    String? EPFno,
    String? enrollNo,
    int? priorityIndex,
    String? profilePic,
    String? remark,
    int? isActive,
    String? branchId,
    String? departmentId,
    int? mealType,
  }) {
    return Employee(
      empNo: empNo ?? this.empNo,
      title: title ?? this.title,
      fullName: fullName ?? this.fullName,
      nic: nic ?? this.nic,
      mobile: mobile ?? this.mobile,
      landLine: landLine ?? this.landLine,
      email: email ?? this.email,
      addressR: addressR ?? this.addressR,
      addressG: addressG ?? this.addressG,
      designationId: designationId ?? this.designationId,
      occupationalCatId: occupationalCatId ?? this.occupationalCatId,
      employeeType: employeeType ?? this.employeeType,
      startDay: startDay ?? this.startDay,
      endDay: endDay ?? this.endDay,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      civilStatus: civilStatus ?? this.civilStatus,
      gender: gender ?? this.gender,
      ETFNo: ETFNo ?? this.ETFNo,
      EPFno: EPFno ?? this.EPFno,
      enrollNo: enrollNo ?? this.enrollNo,
      priorityIndex: priorityIndex ?? this.priorityIndex,
      profilePic: profilePic ?? this.profilePic,
      remark: remark ?? this.remark,
      isActive: isActive ?? this.isActive,
      branchId: branchId ?? this.branchId,
      departmentId: departmentId ?? this.departmentId,
      mealType: mealType ?? this.mealType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'empNo': empNo,
      'title': title,
      'fullName': fullName,
      'nic': nic,
      'mobile': mobile,
      'landLine': landLine,
      'email': email,
      'addressR': addressR,
      'addressG': addressG,
      'designationId': designationId,
      'occupationalCatId': occupationalCatId,
      'employeeType': employeeType,
      'startDay': startDay,
      'endDay': endDay,
      'dateOfBirth': dateOfBirth,
      'civilStatus': civilStatus,
      'gender': gender,
      'ETFNo': ETFNo,
      'EPFno': EPFno,
      'enrollNo': enrollNo,
      'priorityIndex': priorityIndex,
      'profilePic': profilePic,
      'remark': remark,
      'isActive': isActive,
      'branchId': branchId,
      'departmentId': departmentId,
      'mealType': mealType,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      empNo: map['emp_no'],
      title: map['title'],
      fullName: map['full_name'],
      nic: map['nic'],
      mobile: map['mobile'],
      landLine: map['land_line'],
      email: map['email'],
      addressR: map['address_r'],
      addressG: map['address_g'],
      designationId: map['designation_id'],
      occupationalCatId: map['occupational_cat_id'],
      employeeType: map['employee_type'],
      startDay: map['start_day'],
      endDay: map['end_day'],
      dateOfBirth: map['date_of_birth'],
      civilStatus: map['civil_status'],
      gender: map['gender'],
      ETFNo: map['ETF_no'],
      EPFno: map['EPF_no'],
      enrollNo: map['Enroll_no'],
      priorityIndex: map['priority_index']?.toInt(),
      profilePic: map['profile_pic'],
      remark: map['remark'],
      isActive: map['is_active']?.toInt(),
      branchId: map['branch_id'],
      departmentId: map['department_id'],
      mealType: map['meal_type']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(empNo: $empNo, title: $title, fullName: $fullName, nic: $nic, mobile: $mobile, landLine: $landLine, email: $email, addressR: $addressR, addressG: $addressG, designationId: $designationId, occupationalCatId: $occupationalCatId, employeeType: $employeeType, startDay: $startDay, endDay: $endDay, dateOfBirth: $dateOfBirth, civilStatus: $civilStatus, gender: $gender, ETFNo: $ETFNo, EPFno: $EPFno, enrollNo: $enrollNo, priorityIndex: $priorityIndex, profilePic: $profilePic, remark: $remark, isActive: $isActive, branchId: $branchId, departmentId: $departmentId, mealType: $mealType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.empNo == empNo &&
        other.title == title &&
        other.fullName == fullName &&
        other.nic == nic &&
        other.mobile == mobile &&
        other.landLine == landLine &&
        other.email == email &&
        other.addressR == addressR &&
        other.addressG == addressG &&
        other.designationId == designationId &&
        other.occupationalCatId == occupationalCatId &&
        other.employeeType == employeeType &&
        other.startDay == startDay &&
        other.endDay == endDay &&
        other.dateOfBirth == dateOfBirth &&
        other.civilStatus == civilStatus &&
        other.gender == gender &&
        other.ETFNo == ETFNo &&
        other.EPFno == EPFno &&
        other.enrollNo == enrollNo &&
        other.priorityIndex == priorityIndex &&
        other.profilePic == profilePic &&
        other.remark == remark &&
        other.isActive == isActive &&
        other.branchId == branchId &&
        other.departmentId == departmentId &&
        other.mealType == mealType;
  }

  @override
  int get hashCode {
    return empNo.hashCode ^
        title.hashCode ^
        fullName.hashCode ^
        nic.hashCode ^
        mobile.hashCode ^
        landLine.hashCode ^
        email.hashCode ^
        addressR.hashCode ^
        addressG.hashCode ^
        designationId.hashCode ^
        occupationalCatId.hashCode ^
        employeeType.hashCode ^
        startDay.hashCode ^
        endDay.hashCode ^
        dateOfBirth.hashCode ^
        civilStatus.hashCode ^
        gender.hashCode ^
        ETFNo.hashCode ^
        EPFno.hashCode ^
        enrollNo.hashCode ^
        priorityIndex.hashCode ^
        profilePic.hashCode ^
        remark.hashCode ^
        isActive.hashCode ^
        branchId.hashCode ^
        departmentId.hashCode ^
        mealType.hashCode;
  }
}
