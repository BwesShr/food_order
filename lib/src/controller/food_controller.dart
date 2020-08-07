import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/model/extra.dart';
import 'package:food_order/src/model/food.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/model/ingrident.dart';
import 'package:food_order/src/repository/cart_repo.dart';
import 'package:food_order/src/repository/food_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FoodController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  Food food;
  Cart cart;
  int cartCount;
  bool excerpt;
  int quantity;
  List<Ingrident> ingridents = new List(); // ingridents to be removedd
  List<Extra> extras = new List(); // ingridents to be added

  FoodController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    quantity = 1;
    cartCount = 0;
    excerpt = true;
  }

  void listenForFood({int foodId, String message}) async {
    await Future.delayed(Duration(seconds: 2));
    getFoods().forEach((item) {
      setState(() {
        food = getFoods().firstWhere((data) => data.id == foodId);
      });
    });
  }

  void listenForCart({int foodId, String message}) async {
    await Future.delayed(Duration(seconds: 2));
    getFoodCart().forEach((item) {
      setState(() {
        cart = getFoodCart().firstWhere((data) => data.food.id == foodId);
        food = cart.food;
        quantity = cart.quantity;
        ingridents.addAll(cart.ingridents);
        extras.addAll(cart.extras);
      });
    });
  }

  void listenForCartCount({String message}) async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      cartCount = getFoodCart().length;
    });
  }

  void setExcerpt() {
    setState(() {
      excerpt = false;
    });
  }

  void addToCart(Food food) {}

  addToFavourite(Food food) {}

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

  bool checkIngrident(Ingrident ingrident) {
    Ingrident existingItem = ingridents
        .firstWhere((item) => item.name == ingrident.name, orElse: () => null);
    if (existingItem != null) {
      return true;
    } else {
      return false;
    }
  }

  bool checkExtra(Extra extra) {
    Extra existingItem = extras.firstWhere((item) => item.name == extra.name,
        orElse: () => null);
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

  void listenFoodExtraClicked(Extra extra) {
    Extra existingItem = extras.firstWhere((item) => item.name == extra.name,
        orElse: () => null);
    setState(() {
      if (existingItem != null) {
        extras.remove(extra);
      } else {
        extras.add(extra);
      }
    });
  }
}
