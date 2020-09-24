import 'package:flutter/material.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'home/home_food_category.dart';
import 'home/home_promo_widget.dart';
import 'home/home_trending_food.dart';

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
            HomePromoWidget(controller: widget.controller),
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
