import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/walkthrough.dart';
import 'package:food_order/src/repository/walkthrough_repo.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';

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
    print('length: ${walkthroughs.length}');
  }

  void finishWalkthrough() {
    _saveData.saveBool(_saveData.APP_FIRST_RUN, false);
    Navigator.of(context)
        .pushReplacementNamed(homeRoute, arguments: {arg_current_tab: 0});
  }

  void updatePageIndex(int index) {
    pageIndex = index;
  }

  int getPageIndex() {
    return pageIndex;
  }
}
