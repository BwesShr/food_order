import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Payment {
  int id;
  String status;
  String method;

  Payment.empty();

  Payment({
    @required this.id,
    @required this.status,
    @required this.method,
  });

  Payment.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        status = jsonMap['status'] ?? '',
        method = jsonMap['method'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'method': method,
    };
  }
}
