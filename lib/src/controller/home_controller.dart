import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/repository/category_repo.dart';
import 'package:food_order/src/repository/food_repo.dart';
import 'package:food_order/src/utils/local_strings.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Category> categories = new List();
  List<Food> trendingFoods = new List();

  HomeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshHome() async {
    categories.clear();
    trendingFoods.clear();
    listenForFoodCategory();
    listenForTrendingFoods();
  }

  void listenForFoodCategory({String message}) async {
    final Stream<Category> stream = await getProductCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForTrendingFoods({String message}) async {
    final Stream<Food> stream = await getTrendingFoods();
    stream.listen((Food _food) {
      setState(() => trendingFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
}
