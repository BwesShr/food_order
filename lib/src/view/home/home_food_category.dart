import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/widget/food/food_category_tile.dart';
import 'package:food_order/src/widget/progress_dialog.dart';

class HomeFoodCategory extends StatefulWidget {
  HomeFoodCategory({
    Key key,
    @required this.controller,
  });
  final HomeController controller;

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
          padding: EdgeInsets.only(
            left: _appConfig.horizontalSpace(),
          ),
          child: Text(
            LocaleKeys.all_items_title.tr(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(height: _appConfig.smallSpace()),
        Container(
          height: _appConfig.appWidth(25),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: _appConfig.horizontalSpace()),
              widget.controller.categories.length == 0
                  ? FoodHorizontalProgressDialog(
                      size: _appConfig.appHeight(15),
                      itemCount: 6,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.controller.categories.length,
                      itemBuilder: (context, index) {
                        Category category = widget.controller.categories[index];

                        return FoodCategoryTile(
                          category: category,
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
