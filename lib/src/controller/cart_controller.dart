import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/repository/cart_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CartController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  List<Cart> checkOutCarts = <Cart>[];
  double taxAmount = 0.0;
  double deliveryFee = 50.0;
  int cartCount = 0;
  double subTotal = 0.0;
  double total = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading;

  CartController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    isLoading = true;
  }

  Future<void> refreshCarts() async {
    listenForCarts(message: LocaleKeys.carts_refreshed_successfuly.tr());
  }

  void listenForCarts({String message}) async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      carts = getFoodCart();
      isLoading = false;
    });
  }

  // void listenForCarts({String message}) async {
  //   final Stream<Cart> stream = await getCart();
  //   stream.listen((Cart _cart) {
  //     if (!carts.contains(_cart)) {
  //       setState(() {
  //         carts.add(_cart);
  //       });
  //     }
  //   }, onError: (a) {
  //     scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text(LocaleKeys.verify_internet_connection).tr(),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message).tr(),
  //       ));
  //     }
  //   });
  // }

  void listenForCartsCount({String message}) async {
    final Stream<int> stream = await getCartCount();
    stream.listen((int _count) {
      setState(() {
        this.cartCount = _count;
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(LocaleKeys.verify_internet_connection).tr(),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message).tr(),
        ));
      }
    });
  }

  void removeFromCart(Cart _cart) async {
    setState(() {
      this.carts.remove(_cart);
    });
    removeCart(_cart).then((value) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(LocaleKeys.the_food_was_removed_from_your_cart
            .tr(namedArgs: {'foodName': _cart.food.name})),
      ));
    });
  }

  void calculateSubtotal() async {
    subTotal = 0;
    carts.forEach((cart) {
      if (cart.selected) {
        if (cart.food.discount == 0) {
          subTotal += cart.quantity * cart.food.price;
        } else {
          double discountedPrice =
              cart.food.price - ((cart.food.discount * cart.food.price) / 100);
          subTotal += cart.quantity * discountedPrice;
        }
      }
    });
    // deliveryFee = carts[0].food.restaurant.deliveryFee;
    taxAmount = (subTotal + deliveryFee) * 10 / 100;
    total = subTotal + taxAmount + deliveryFee;
    setState(() {});
  }

  selectCartItem(Cart cart) {
    setState(() {
      cart.selected = !cart.selected;
      if (cart.selected)
        checkOutCarts.add(cart);
      else
        checkOutCarts.remove(cart);

      calculateSubtotal();
    });
  }

  incrementQuantity(Cart cart) {
    if (cart.quantity <= 99) {
      setState(() {
        ++cart.quantity;
        updateCart(cart);
        calculateSubtotal();
      });
    }
  }

  decrementQuantity(Cart cart) {
    if (cart.quantity > 1) {
      setState(() {
        --cart.quantity;
        updateCart(cart);
        calculateSubtotal();
      });
    }
  }

  addToWishList(Cart cart) {}

  void checkOut() {
    if (checkOutCarts.length == 0) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          LocaleKeys.no_cart_item.tr(),
        ),
      ));
    } else {}
  }
}
