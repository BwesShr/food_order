import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderStatus {
  int id;
  String status;

  OrderStatus.empty();

  OrderStatus({
    @required this.id,
    @required this.status,
  });

  OrderStatus.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        status = jsonMap['status'] != null ? jsonMap['status'] : '';
}
