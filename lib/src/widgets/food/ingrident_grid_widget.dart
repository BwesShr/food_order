import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/controller/food_controller.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class IngridentGridWidget extends StatelessWidget {
  IngridentGridWidget({
    Key key,
    @required this.controller,
    @required this.ingridents,
  }) : super(key: key);

  final FoodController controller;
  final List<Ingrident> ingridents;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Wrap(
      spacing: _appConfig.horizontalPadding(1),
      runSpacing: _appConfig.verticalPadding(0.5),
      children: List.generate(ingridents.length, (index) {
        Ingrident ingrigent = ingridents[index];
        return GestureDetector(
          onTap: () => controller.listenFoodIngridentClicked(ingrigent),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalPadding(1),
                vertical: _appConfig.verticalPadding(1)),
            decoration: BoxDecoration(
              color: controller.checkIngridentSelected(ingrigent)
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(_appConfig.borderRadius()),
              border: Border.all(color: Theme.of(context).buttonColor),
            ),
            child: Text(
              ingrigent.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 10.0,
                  color: controller.checkIngridentSelected(ingrigent)
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor),
            ),
          ),
        );
      }),
    );
  }
}
