import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ingrident {
  int id;
  String name;
  double price;

  Ingrident({
    @required this.id,
    @required this.name,
    @required this.price,
  });

  factory Ingrident.fromJSON(Map<String, dynamic> json) => Ingrident(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? 0.0 : json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
      };
}
