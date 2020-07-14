import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/images.dart';
import 'package:food_order/src/utils/local_strings.dart';
import 'package:food_order/src/widget/blink_widget.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/widget/food_tile.dart';
import 'package:food_order/src/widget/no_data.dart';

class HomeTrendingFood extends StatefulWidget {
  HomeTrendingFood({Key key, @required this.trendingFoods}) : super(key: key);
  final List<Food> trendingFoods;

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
          padding: EdgeInsets.symmetric(
            horizontal: _appConfig.horizontalPadding(5),
          ),
          child: Text(
            most_popular_title,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          height: _appConfig.appWidth(60),
          child: widget.trendingFoods.isEmpty
              ? NoDataHorizontalList(
                  size: _appConfig.appWidth(100),
                  itemCount: 2,
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.trendingFoods.length,
                  itemBuilder: (context, index) {
                    Food food = widget.trendingFoods[index];
                    return FoodTile(
                      food: food,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
