import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/repository/category_repo.dart';
import 'package:food_order/src/utils/local_strings.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;

  CategoryController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshCategory() async {}
}
