import 'package:flutter/material.dart';

class Ingrident {
  int id;
  String name;
  double price;

  Ingrident.empty();

  Ingrident({
    @required this.id,
    @required this.name,
    @required this.price,
  });

  Ingrident.fromJSON(Map<String, dynamic> jsonMap)
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
