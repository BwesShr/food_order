import 'package:food_order/src/model/food.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/category_repo.dart';
import 'package:food_order/src/utils/local_strings.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FoodController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Food> foods = new List();

  FoodController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshFood() async {
    foods.clear();
    listenForFoodsByCategory(message: food_refreshed_successfuly);
  }

  void listenForFoodsByCategory({int id, String message}) async {
    final Stream<Food> stream = await getProductsByCategory(id);
    stream.listen((Food _food) {
      setState(() {
        foods.add(_food);
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('verify_your_internet_connection'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
}
