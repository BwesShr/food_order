import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class Cart {
  int id;
  int userId;
  Food food;
  int quantity;
  List<Ingrident> ingridents;
  List<Ingrident> extras;

  Cart.empty();

  Cart({
    @required this.id,
    @required this.userId,
    @required this.food,
    @required this.quantity,
    @required this.ingridents,
    @required this.extras,
  });

  Cart.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    quantity = jsonMap['quantity'] != null ? jsonMap['quantity'] : 0;
    food = jsonMap['food'] != null
        ? Food.fromJSON(jsonMap['food'])
        : new Food.empty();
    ingridents = jsonMap['ingridents'] != null
        ? List.from(jsonMap['ingridents'])
            .map((element) => Ingrident.fromJSON(element))
            .toList()
        : [];
    extras = jsonMap['extras'] != null
        ? List.from(jsonMap['extras'])
            .map((element) => Ingrident.fromJSON(element))
            .toList()
        : [];
    // food.price = getFoodPrice();
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['user_id'] = userId;
    map['quantity'] = quantity;
    map['food_id'] = food.id;
    map['ingridents'] = ingridents.map((element) => element.id).toList();
    map['extras'] = extras.map((element) => element.id).toList();
    return map;
  }

  double getFoodPrice() {
    double result = food.price;
    if (extras.isNotEmpty) {
      extras.forEach((Ingrident extra) {
        result += extra.price != null ? extra.price : 0;
      });
    }
    return result;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }
}
