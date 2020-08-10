import 'package:flutter/material.dart';
import 'package:food_order/src/controller/category_controller.dart';
import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/connectivity_check.dart';
import 'package:food_order/src/widget/food/grid_food_tile.dart';
import 'package:food_order/src/widget/progress_dialog.dart';
import 'package:food_order/src/widget/search_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryFoodScreen extends StatefulWidget {
  CategoryFoodScreen({Key key, this.category}) : super(key: key);
  final Category category;

  @override
  _CategoryFoodScreenState createState() => _CategoryFoodScreenState();
}

class _CategoryFoodScreenState extends StateMVC<CategoryFoodScreen> {
  CategoryController _controller;

  _CategoryFoodScreenState() : super(CategoryController()) {
    _controller = controller;
  }

  @override
  void initState() {
    _controller.listenForFoodsByCategory(id: widget.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return SafeArea(
      child: Scaffold(
        appBar: Appbar(
          title: widget.category.name,
        ),
        body: ConnectivityCheck(
          child: RefreshIndicator(
            onRefresh: _controller.refreshFood,
            child: _controller.foods.isEmpty
                ? FoodGridProgressDialog(
                    itemCount: _appConfig.gridItemCount(),
                  )
                : ListView(
                    children: <Widget>[
                      SearchBarWidget(),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: _appConfig.horizontalSpace(),
                            vertical: _appConfig.verticalSpace()),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: _controller.foods.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (_appConfig.appWidth(50)) /
                                (_appConfig.appWidth(60)),
                          ),
                          itemBuilder: (context, index) {
                            Food food = _controller.foods[index];

                            return GridFoodTile(
                              food: food,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
