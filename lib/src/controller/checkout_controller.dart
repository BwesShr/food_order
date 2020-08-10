import 'package:flutter/material.dart';
import 'package:food_order/src/model/address.dart';
import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/model/order.dart';
import 'package:food_order/src/model/order_status.dart';
import 'package:food_order/src/model/user.dart';
import 'package:food_order/src/repository/address_repo.dart';
import 'package:food_order/src/repository/cart_repo.dart';
import 'package:food_order/src/repository/user_repo.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CheckoutController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Cart> carts = new List();
  Address address;
  double vat = 10;
  double taxAmount = 0.0;
  double deliveryFee = 50.0;
  double subTotal = 0.0;
  double total = 0.0;
  bool isLoading;

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    isLoading = true;
    listenForAddress();
    listenForCarts();
  }

  void listenForAddress({String message}) async {
    // TODO: call default delivery address api

    await Future.delayed(Duration(seconds: 3));
    setState(() {
      address = getAddress();
    });
  }

  void listenForCarts({String message}) async {
    await Future.delayed(Duration(seconds: 3));

    carts = getCart();
    calculateSubtotal();
  }

  void calculateSubtotal() async {
    subTotal = 0;
    carts.forEach((cart) {
      if (cart.food.discount == 0) {
        subTotal += cart.quantity * cart.food.price;
      } else {
        double discountedPrice =
            cart.food.price - ((cart.food.discount * cart.food.price) / 100);
        subTotal += cart.quantity * discountedPrice;
      }
    });
    taxAmount = (subTotal + deliveryFee) * vat / 100;
    total = subTotal + taxAmount + deliveryFee;
    setState(() {
      isLoading = false;
    });
  }

  IconData addressIcon() {
    switch (address.type) {
      case Constants.addressTypeHome:
        return Icons.home;
      case Constants.addressTypeWork:
        return Icons.work;
      default:
        return null;
    }
  }

  String getLocation() {
    return address.address + ', ' + address.city;
  }

  Future<void> changeAddress() async {
    var _address = await Navigator.of(context).pushNamed(
      myAddressRoute,
      arguments: {arg_is_checkout: true},
    );
    setState(() {
      address = _address as Address;
    });
  }

  void proceedPayment() {
    Order _order = new Order.empty();

    // User user;
    _order.deliveryFee = deliveryFee;
    _order.tax = vat;
    _order.deliveryAddress = address;
    _order.dateTime = DateTime.now();
    OrderStatus orderStatus = OrderStatus.empty();
    orderStatus.id = 1;
    _order.orderStatus = orderStatus;
    _order.foodOrders = carts;
    // TODO: assign user
    User user = User();
    _order.user = user;
    // TODO: call delivery address selection api

    Navigator.of(context).pushNamed(paymentRoute);
  }
}
