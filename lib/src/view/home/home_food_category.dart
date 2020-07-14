import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/local_strings.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/widget/food_category_tile.dart';
import 'package:food_order/src/widget/no_data.dart';

class HomeFoodCategory extends StatefulWidget {
  HomeFoodCategory({
    Key key,
    @required this.categories,
  });
  final List<Category> categories;

  @override
  _HomeFoodCategoryState createState() => _HomeFoodCategoryState();
}

class _HomeFoodCategoryState extends State<HomeFoodCategory> {
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
            all_items_title,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          height: _appConfig.appWidth(35),
          child: widget.categories.length == 0
              ? NoDataHorizontalList(
                  size: _appConfig.appHeight(10),
                  itemCount: 6,
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    Category category = widget.categories[index];

                    return FoodCategoryTile(
                      category: category,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
