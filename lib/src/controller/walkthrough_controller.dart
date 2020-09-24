import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/model.dart';

import '../route/generated_route.dart';

class WalkthroughController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  int pageIndex;
  List<Walkthrough> walkthroughs = new List();
  final _saveData = SaveData();

  WalkthroughController() {
    pageIndex = 0;
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForWalkThrough({String message}) async {
    final List<Walkthrough> datas = await getWalkthroughs();
    for (Walkthrough walkthrough in datas) {
      setState(() => walkthroughs.add(walkthrough));
    }
  }

  void finishWalkthrough() {
    _saveData.saveBool(_saveData.APP_FIRST_RUN, false);
    Navigator.of(context).pushReplacementNamed(homeRoute, arguments: 0);
  }

  void updateIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  bool checkIndex() {
    return pageIndex < (walkthroughs.length - 1) ? true : false;
  }
}
