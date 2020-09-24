import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/repository/repository.dart';

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

  showMessageWithAction(GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context, String message,
      {String buttonText, VoidCallback onPressed}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      action: buttonText != null
          ? SnackBarAction(
              label: buttonText,
              textColor: Theme.of(context).buttonColor,
              onPressed: onPressed,
            )
          : SnackBarAction(
              label: '',
              onPressed: () {},
            ),
    ));
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

  List<String> createStringFromList(String value) {
    return value.split(', ');
  }

  String createListFromString(List<String> list) {
    String joinedString;
    list.forEach((item) {
      joinedString = (joinedString == null || joinedString == '')
          ? item.toString()
          : joinedString + ',' + item.toString();
    });
    return joinedString;
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

  Map<String, dynamic> getHeader() {
    User _user = currentUser.value;

    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer ${_user.apiToken}'
    };
  }
}
