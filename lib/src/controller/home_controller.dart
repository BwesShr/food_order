import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/model/home_slider.dart';
import 'package:food_order/src/repository/cart_repo.dart';
import 'package:food_order/src/repository/category_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/repository/food_repo.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/slider_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<HomeSlider> sliders = new List();
  List<Category> categories = new List();
  List<Food> trendingFoods = new List();
  int cartCount;

  HomeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshHome() async {
    cartCount = 0;
    categories.clear();
    trendingFoods.clear();
    listenForHomeSlider();
    listenForFoodCategory();
    listenForTrendingFoods();
  }

  void listenForHomeSlider({String message}) async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      sliders = getHomeSlider();
    });
  }

  void listenForFoodCategory({String message}) async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      categories = getCategories();
    });
  }

  void listenForTrendingFoods({String message}) async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      trendingFoods = getFoods();
    });
  }

  void listenForCartCount({String message}) async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      cartCount = getFoodCart().length;
    });
  }

  // void listenForFoodCategory({String message}) async {
  //   final Stream<Category> stream = await getFoodCategories();
  //   stream.listen((Category _category) {
  //     setState(() => categories.add(_category));
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text(LocaleKeys.verify_internet_connection.tr()),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message).tr(),
  //       ));
  //     }
  //   });
  // }
  // void listenForTrendingFoods({String message}) async {
  //   final Stream<Food> stream = await getTrendingFoods();
  //   stream.listen((Food _food) {
  //     setState(() => trendingFoods.add(_food));
  //   }, onError: (a) {
  //     print(a);
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message),
  //       ));
  //     }
  //   });
  // }
}
