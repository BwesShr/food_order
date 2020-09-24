import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'model.dart';

class Order {
  int id;
  List<Cart> foodOrders;
  OrderStatus orderStatus;
  double tax;
  double deliveryFee;
  DateTime dateTime;
  User user;
  Payment payment;
  Address deliveryAddress;

  Order.empty();

  Order({
    @required this.id,
    @required this.foodOrders,
    @required this.orderStatus,
    @required this.tax,
    @required this.deliveryFee,
    @required this.dateTime,
    @required this.user,
    @required this.payment,
    @required this.deliveryAddress,
  });

  Order.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      tax = jsonMap['tax'] != null ? double.tryParse(jsonMap['tax']) : 0.0;
      deliveryFee = jsonMap['delivery_fee'] != null
          ? double.tryParse(jsonMap['delivery_fee'])
          : 0.0;
      orderStatus = jsonMap['order_status'] != null
          ? OrderStatus.fromJSON(jsonMap['order_status'])
          : new OrderStatus.empty();
      dateTime = DateTime.parse(jsonMap['updated_at']);
      user = jsonMap['user'] != null
          ? User.fromJSON(jsonMap['user'])
          : new User.empty();
      deliveryAddress = jsonMap['delivery_address'] != null
          ? Address.fromJSON(jsonMap['delivery_address'])
          : new Address.empty();
      foodOrders = jsonMap['food_orders'] != null
          ? List.from(jsonMap['food_orders'])
              .map((element) => Cart.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["user_id"] = user?.id;
    map["order_status_id"] = orderStatus?.id;
    map["tax"] = tax;
    map["delivery_fee"] = deliveryFee;
    map["foods"] = foodOrders.map((element) => element.toMap()).toList();
    map["payment"] = payment.toMap();
    map["delivery_address_id"] = deliveryAddress?.id ?? null;
    return map;
  }

  Map deliveredMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["order_status_id"] = 5;
    return map;
  }
}
