import 'package:flutter/material.dart';
import 'package:food_order/src/model/ingrident.dart';

import 'extra.dart';
import 'food.dart';

class Cart {
  int id;
  int userId;
  Food food;
  int quantity;
  List<Ingrident> ingridents;
  List<Extra> extras;
  bool selected;

  Cart.empty();

  Cart({
    @required this.id,
    @required this.userId,
    @required this.food,
    @required this.quantity,
    @required this.ingridents,
    @required this.extras,
    @required this.selected,
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
            .map((element) => Extra.fromJSON(element))
            .toList()
        : [];
    selected = jsonMap['selected'] != null ? jsonMap['selected'] : false;
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
    map['selected'] = selected;
    return map;
  }

  double getFoodPrice() {
    double result = food.price;
    if (extras.isNotEmpty) {
      extras.forEach((Extra extra) {
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
