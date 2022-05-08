import 'dart:convert';

class User {
  String? empNo;
  String? username;
  String? passwordHash;
  int? roleId;
  User({
    this.empNo,
    this.username,
    this.passwordHash,
    this.roleId,
  });

  get title => null;

  Map<String, dynamic> toMap() {
    return {
      'emp_no': empNo,
      'username': username,
      'password_hash': passwordHash,
      'role_id': roleId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      empNo: map['emp_no'] ?? '',
      username: map['username'] ?? '',
      passwordHash: map['password_hash'] ?? '',
      roleId: map['role_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
