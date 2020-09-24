import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

class SearchController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Food> foods = new List();
  List<String> filterCategories = new List();
  List<String> filterTypes = new List();
  final _functions = Functions();
  bool isLoading;

  double lowerValue = 0.0;
  double upperValue = 1000.0;
  double filterLowerValue;
  double filterUpperValue;

  SearchController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    isLoading = false;
    filterLowerValue = lowerValue;
    filterUpperValue = upperValue;
  }

  Future<void> listenForSearch(String value) async {
    setState(() {
      isLoading = true;
    });
    Map body = {
      'category': _functions.createListFromString(filterCategories),
      'type': _functions.createListFromString(filterTypes),
      'price': '$filterLowerValue-$filterUpperValue',
    };
    final List<Food> _foods = await getSearchFoods(body: body);
    setState(() {
      foods.addAll(_foods);
      isLoading = false;
    });
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

  clearFilterData() {
    filterCategories.clear();
    filterTypes.clear();
    filterLowerValue = lowerValue;
    filterUpperValue = upperValue;
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

  bool checkFilterTypeClicked(String value) {
    if (filterTypes.contains(value)) {
      return true;
    } else {
      return false;
    }
  }
}
