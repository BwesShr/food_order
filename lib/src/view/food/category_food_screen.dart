import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/controller/category_controller.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryFoodScreen extends StatefulWidget {
  CategoryFoodScreen({
    Key key,
    this.routeArgument,
  }) : super(key: key);

  final RouteArgument routeArgument;

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
    _controller.listenForFoodsByCategory(id: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    // TODO: implement pagination

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: Appbar(
            title: widget.routeArgument.title,
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
      ),
    );
  }
}
