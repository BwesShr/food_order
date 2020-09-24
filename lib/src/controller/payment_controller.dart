import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

class OrderController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  Order order = new Order.empty();
  bool isLoading;
  bool isOrderSuccessFul;

  OrderController() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    isLoading = true;
    isOrderSuccessFul = false;
  }

  listenForOrder({String message}) async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isLoading = false;
      order = getOrder();
    });
  }

  processPayment(String paymentMethod) async {
    setState(() {
      isLoading = true;
    });
    Payment payment = new Payment.empty();

    // TODO: define payment status

    payment.method = paymentMethod;
    order.payment = payment;

    // TODO: call order complete api

    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isLoading = false;
      isOrderSuccessFul = true;
    });

    // Navigator.of(context).pushNamedAndRemoveUntil(
    //   homeRoute,
    //   (Route<dynamic> route) => false,
    //   arguments: {
    //     arg_current_tab: 0,
    //   },
    // );
  }
}
