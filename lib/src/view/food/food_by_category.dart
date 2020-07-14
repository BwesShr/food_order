import 'package:flutter/material.dart';
import 'package:food_order/src/controller/food_controller.dart';
import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/food_tile.dart';
import 'package:food_order/src/widget/no_data.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FoodByCategory extends StatefulWidget {
  FoodByCategory({Key key, this.category}) : super(key: key);
  final Category category;

  @override
  _FoodByCategoryState createState() => _FoodByCategoryState();
}

class _FoodByCategoryState extends StateMVC<FoodByCategory> {
  FoodController _controller;

  _FoodByCategoryState() : super(FoodController()) {
    _controller = controller;
  }

  @override
  void initState() {
    print('id: ${widget.category.id}');
    _controller.listenForFoodsByCategory(id: widget.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: Appbar(
            title: widget.category.name,
          ),
          body: RefreshIndicator(
            onRefresh: _controller.refreshFood,
            child: Container(
              width: _appConfig.appWidth(100),
              height: _appConfig.appHeight(100),
              child: _controller.foods.isEmpty
                  ? NoDataGrid(
                      size: _appConfig.appWidth(100) * 0.5,
                      itemCount: _appConfig.gridItemCount(),
                    )
                  : GridView.builder(
                      itemCount: _controller.foods.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (_appConfig.appWidth(1) * 0.5) /
                            (_appConfig.appWidth(1) * 0.5),
                      ),
                      itemBuilder: (context, index) {
                        Food food = _controller.foods[index];

                        return FoodTile(
                          food: food,
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
