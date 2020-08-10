import 'package:food_order/src/controller/home_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/search_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'home/home_trending_food.dart';
import 'home/home_food_category.dart';
import 'home/home_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
    this.parentScaffoldKey,
    this.controller,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final HomeController controller;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  // HomeController _controller;
  // _HomeScreenState() : super(HomeController()) {
  //   _controller = controller;
  // }

  // @override
  // void initState() {
  //   _controller.listenForHomeSlider();
  //   _controller.listenForFoodCategory();
  //   _controller.listenForTrendingFoods();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return RefreshIndicator(
      onRefresh: widget.controller.refreshHome,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: _appConfig.verticalPadding(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            HomeSliderWidget(controller: widget.controller),
            SearchBarWidget(),
            HomeFoodCategory(controller: widget.controller),
            SizedBox(height: _appConfig.smallSpace()),
            HomeTrendingFood(controller: widget.controller),
            SizedBox(height: _appConfig.bigSpace()),
          ],
        ),
      ),
    );
  }
}
