import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/repository/settings_repo.dart';

class Functions {
  // for mapping data retrieved form json array
  getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  String removeHtml(String description, int count) {
    description = description.replaceAll('<p>', '');
    description = description.replaceAll('</p>', '');

    if (count == 0) {
      return description;
    } else {
      return description;
    }
  }

  getDiscountedPrice(Food food) {
    double discount = food.price - ((food.discount * food.price) / 100);
    return discount.toStringAsFixed(2);
  }

  List<String> stringToList(String value) {
    return value.split(', ');
  }

  String getPrice(Cart cart) {
    if (cart.food.discount == 0) {
      return (cart.food.price * cart.quantity).toStringAsFixed(2);
    } else {
      double price =
          cart.food.price - ((cart.food.discount * cart.food.price) / 100);
      return (price * cart.quantity).toStringAsFixed(2);
    }
  }
}
