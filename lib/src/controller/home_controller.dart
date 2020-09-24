import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<HomePromo> promos = new List();
  List<Category> categories = new List();
  List<Food> trendingFoods = new List();
  final _functions = Functions();
  // int cartCount;

  HomeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    listenForPromoSlider();
    listenForFoodCategory();
    listenForTrendingFoods();
    listenForCartCount();
  }

  Future<void> refreshHome() async {
    categories.clear();
    trendingFoods.clear();

    listenForPromoSlider();
    listenForFoodCategory();
    listenForTrendingFoods();
    listenForCartCount();
  }

  void listenForCartCount() {
    getCartCount();
  }

  void listenForPromoSlider() async {
    // final Stream<HomePromo> stream = await getPromoSlider();
    // stream.listen((HomePromo _slider) {
    //   setState(() => promos.add(_slider));
    // }, onError: (error) {
    //   // print('promo error: $error');
    // }, onDone: () {
    //   // status done
    //   // _functions.showMessageWithAction(
    //   //     scaffoldKey, context, LocaleKeys.category_refreshed_successfuly.tr());
    // });

    List<HomePromo> _sliders = await getPromoSlider();
    for (HomePromo _slider in _sliders) {
      setState(() => promos.add(_slider));
    }
  }

  void listenForFoodCategory() async {
    List<Category> _categories = await getFoodCategories();
    setState(() => categories.addAll(_categories));
  }

  void listenForTrendingFoods() async {
    List<Food> _foods = await getTrendingFoods();
    setState(() => trendingFoods.addAll(_foods));
  }
}
