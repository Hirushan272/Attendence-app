import 'dart:convert';

class ResponseModel {
  int? statusCode;
  String? message;
  ResponseModel({
    this.statusCode,
    this.message,
  });

  ResponseModel copyWith({
    int? statusCode,
    String? message,
  }) {
    return ResponseModel(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      statusCode: map['statusCode']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseModel(statusCode: $statusCode, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.statusCode == statusCode &&
        other.message == message;
  }

  @override
  int get hashCode => statusCode.hashCode ^ message.hashCode;
}
