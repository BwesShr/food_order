import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/repository/food_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchController extends ControllerMVC {
  List<Food> foods = new List();
  List<String> filterCategories = new List();
  List<String> filterTypes = new List();
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading;

  double lowerValue = 0.0;
  double upperValue = 1000.0;
  double filterLowerValue = 0.0;
  double filterUpperValue = 1000.0;

  SearchController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    isLoading = false;
    filterLowerValue = lowerValue;
    filterUpperValue = upperValue;
  }
  clearFilterData() {
    filterCategories.clear();
    filterTypes.clear();
    filterLowerValue = lowerValue;
    filterUpperValue = upperValue;
  }

  void listenFilterCategory(String value) {
    setState(() {
      if (filterCategories.contains(value)) {
        filterCategories.remove(value);
      } else {
        filterCategories.add(value);
      }
    });
  }

  listenFilterType(String value) {
    setState(() {
      if (filterTypes.contains(value)) {
        filterTypes.remove(value);
      } else {
        filterTypes.add(value);
      }
    });
  }

  bool checkFilterCategoryClicked(String value) {
    if (filterCategories.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  checkFilterTypeClicked(String value) {
    if (filterTypes.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> listenForSearch(String value) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      foods = getFoods();

      isLoading = false;
    });
  }
}
