import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';
import '../route/generated_route.dart';

class FoodController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Ingrident> ingridents = new List(); // ingridents to be removedd
  List<Ingrident> extras = new List(); // ingridents to be added
  final _functions = Functions();
  Food food;
  Cart cart;
  // int cartCount;
  int quantity;

  bool showLoginDialog;

  FoodController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    quantity = 1;
    // cartCount = 0;
    showLoginDialog = false;
  }

  void listenForFoodItem(int foodId) async {
    Food _food = await getFoodById(foodId);
    setState(() => food = _food);
  }

  void listenForCartItem({int foodId, String message}) async {
    final Stream<Cart> stream = await getCartById(foodId);
    stream.listen((Cart _cart) {
      setState(() {
        cart = _cart;
        food = _cart.food;
        quantity = _cart.quantity;
        ingridents.addAll(_cart.ingridents);
        extras.addAll(_cart.extras);
      });
    }, onError: (error) {
      // print('food error: $error');
    }, onDone: () {
      // done status
    });
  }

  void addToCart() {
    // TODO: call add food to cart api

    // TODO: on successful show snackbar

    _functions.showMessageWithAction(
      scaffoldKey,
      context,
      LocaleKeys.added_to_cart_message.tr(),
      buttonText: LocaleKeys.action_goto_cart.tr(),
      onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
        homeRoute,
        (Route<dynamic> route) => false,
        arguments: 1,
      ),
    );
  }

  addToWishList() {
    // TODO: call add food to wishlist api

    // TODO: on successful show snackbar

    _functions.showMessageWithAction(
      scaffoldKey,
      context,
      LocaleKeys.added_to_wishlist_message.tr(),
    );
  }

  // void listenForFood({String foodId, String message}) async {
  //   final Stream<Food> stream = await getFood(foodId);
  //   stream.listen((Food _food) {
  //     setState(() => food = _food);
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey.currentState?.showSnackBar(SnackBar(
  //       content: Text(S.current.verify_your_internet_connection),
  //     ));
  //   }, onDone: () {
  //     calculateTotal();
  //     if (message != null) {
  //       scaffoldKey.currentState?.showSnackBar(SnackBar(
  //         content: Text(message),
  //       ));
  //     }
  //   });
  // }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) quantity -= 1;
    });
  }

  void increaseQuantity() {
    setState(() {
      if (quantity < 99) quantity += 1;
    });
  }

  bool checkIngridentSelected(Ingrident ingrident) {
    Ingrident existingItem = ingridents
        .firstWhere((item) => item.name == ingrident.name, orElse: () => null);
    if (existingItem != null) {
      return true;
    } else {
      return false;
    }
  }

  bool checkExtraSelected(Ingrident extra) {
    Ingrident existingItem = extras
        .firstWhere((item) => item.name == extra.name, orElse: () => null);
    if (existingItem != null) {
      return true;
    } else {
      return false;
    }
  }

  void listenFoodIngridentClicked(Ingrident ingrident) {
    Ingrident existingItem = ingridents
        .firstWhere((item) => item.name == ingrident.name, orElse: () => null);
    setState(() {
      if (existingItem != null) {
        ingridents.remove(ingrident);
      } else {
        ingridents.add(ingrident);
      }
    });
  }

  void listenFoodExtraClicked(Ingrident extra) {
    Ingrident existingItem = extras
        .firstWhere((item) => item.name == extra.name, orElse: () => null);
    setState(() {
      if (existingItem != null) {
        extras.remove(extra);
      } else {
        extras.add(extra);
      }
    });
  }

  Future<void> userLogin() async {
    final message = await Navigator.of(context).pushNamed(loginRoute);
    if (message != null) {
      showLoginDialog = false;
    }
    setState(() {
      _functions.showMessageWithAction(scaffoldKey, context, message);
    });
  }
}
