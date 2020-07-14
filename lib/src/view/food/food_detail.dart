import 'package:flutter/material.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/appbar.dart';

class FoodDetail extends StatefulWidget {
  FoodDetail({
    Key key,
    this.food,
  }) : super(key: key);

  final Food food;

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: Appbar(
            title: widget.food.name,
          ),
          body: Container(
            width: _appConfig.appWidth(100),
            height: _appConfig.appHeight(100),
          ),
        ),
      ),
    );
  }
}
