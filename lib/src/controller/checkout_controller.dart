import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/route/generated_route.dart';
import 'package:food_order/src/utils/constants.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

class CheckoutController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Cart> carts = new List();
  double vat = 10;
  double taxAmount = 0.0;
  double deliveryFee = 50.0;
  double subTotal = 0.0;
  double total = 0.0;
  double discount = 0.0;
  String voucher;
  String voucherMessage;
  bool isLoading;
  bool isVoucherLoading;
  final _functions = Functions();

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    isLoading = true;
    isVoucherLoading = false;
    listenForDeliveryAddress();
    listenForCarts();
  }

  void listenForDeliveryAddress() async {
    getDeliveryAddress();
  }

  void listenForCarts() async {
    List<Cart> _carts = await getCart();
    setState(() {
      carts.addAll(_carts);
    });
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
    total -= discount;
    setState(() {
      isLoading = false;
      isVoucherLoading = false;
    });
  }

  IconData addressIcon() {
    switch (deliveryAddress.value.type) {
      case Constants.addressTypeHome:
        return Icons.home;
      case Constants.addressTypeWork:
        return Icons.work;
      default:
        return null;
    }
  }

  String getLocation() {
    return deliveryAddress.value.address + ', ' + deliveryAddress.value.city;
  }

  Future<void> changeAddress() async {
    var _address = await Navigator.of(context).pushNamed(myAddressRoute);
    setState(() {
      deliveryAddress.value = _address as Address;
    });
  }

  void proceedPayment() {
    Order _order = new Order.empty();

    OrderStatus orderStatus = OrderStatus.empty();
    orderStatus.id = 1;

    _order.foodOrders = carts;
    _order.orderStatus = orderStatus;
    _order.tax = vat;
    _order.deliveryFee = deliveryFee;
    _order.dateTime = DateTime.now();
    _order.user = currentUser.value;
    _order.deliveryAddress = deliveryAddress.value;

    cartCheckout(_order).then((response) {
      if (response != null) {
        _functions.showMessageWithAction(
            scaffoldKey, context, response['message']);
        if (response['status']) {
          Navigator.of(context).pushNamed(paymentRoute);
        }
      }
    });
  }

  checkVoucher() {
    validateVoucher(voucher).then((response) {
      if (response['status']) {
        switch (response['discount_type']) {
          case 'percantage':
            discount = (total * response['discount'].toDouble()) / 100;
            break;
          case 'amount':
            discount = response['discount'];
            break;
        }
        calculateSubtotal();
      } else {
        setState(() {
          voucherMessage = 'Please enter the correct voucher code';
        });
      }
    });
  }
}
