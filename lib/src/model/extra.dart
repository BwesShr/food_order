import 'package:flutter/material.dart';

class Extra {
  int id;
  String name;
  double price;

  Extra.empty();

  Extra({
    @required this.id,
    @required this.name,
    this.price,
  });

  Extra.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : null;

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    return map;
  }
}
