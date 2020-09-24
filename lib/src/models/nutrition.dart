import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nutrition {
  int id;
  String name;
  double quantity;

  Nutrition.empty();

  Nutrition({
    @required this.id,
    @required this.name,
    @required this.quantity,
  });

  Nutrition.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        quantity = double.tryParse(jsonMap['quantity']);
}
