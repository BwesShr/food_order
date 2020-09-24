import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/widgets/widget.dart';

class HomeTrendingFood extends StatefulWidget {
  HomeTrendingFood({Key key, this.controller}) : super(key: key);

  final HomeController controller;

  @override
  _HomeTrendingFoodState createState() => _HomeTrendingFoodState();
}

class _HomeTrendingFoodState extends State<HomeTrendingFood> {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: _appConfig.horizontalSpace(),
          ),
          child: Text(
            LocaleKeys.most_popular_title.tr(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(height: _appConfig.smallSpace()),
        Container(
          height: _appConfig.appHeight(30),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: _appConfig.horizontalSpace()),
              widget.controller.trendingFoods.isEmpty
                  ? FoodHorizontalProgressDialog(
                      itemCount: 2,
                      size: _appConfig.appHeight(30),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.controller.trendingFoods.length,
                      itemBuilder: (context, index) {
                        Food food = widget.controller.trendingFoods[index];
                        return FoodTile(
                          food: food,
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
