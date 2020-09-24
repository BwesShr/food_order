import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

class CategoryController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Food> foods = new List();

  CategoryController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshFood() async {
    foods.clear();
    listenForFoodsByCategory(
        message: LocaleKeys.food_refreshed_successfuly.tr());
  }

  void listenForFoodsByCategory({int id, String message}) async {
    final List<Food> _foods = await getFoodsByCategory(id);
    setState(() => foods.addAll(_foods));
  }

  // void listenForFoodsByCategory({int id, String message}) async {
  //   final Stream<Food> stream = await getProductsByCategory(id);
  //   stream.listen((Food _food) {
  //     setState(() {
  //       foods.add(_food);
  //     });
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

}
