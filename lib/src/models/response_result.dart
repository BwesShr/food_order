import 'dart:convert';

class ResponseResult {
  ResponseResult({
    this.data,
    this.status,
    this.message,
    this.statusCode,
  });
  var data;
  String status;
  String message;
  int statusCode;

  factory ResponseResult.fromJson(String response) {
    Map<String, dynamic> map = json.decode(response);
    return ResponseResult(
      data: map['data'] == null ? null : map['data'],
      status: map['status'] == null ? null : map['status'],
      message: map['message'] == null ? null : map['message'],
      statusCode: map['status_code'] == null ? null : map['status_code'],
    );
  }

  Map<String, dynamic> toMap() => {
        'data': data == null ? null : data,
        'status': status == null ? null : status,
        'message': message == null ? null : message,
        'status_code': statusCode == null ? null : statusCode,
      };
}
