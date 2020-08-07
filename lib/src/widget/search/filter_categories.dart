import 'package:flutter/material.dart';
import 'package:food_order/src/controller/search_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';

class FilterCategories extends StatelessWidget {
  FilterCategories({
    Key key,
    @required this.controller,
    @required this.categories,
  }) : super(key: key);

  final SearchController controller;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Wrap(
      spacing: _appConfig.horizontalPadding(2),
      runSpacing: _appConfig.verticalPadding(2),
      children: List.generate(
        categories.length,
        (index) {
          return InkWell(
            onTap: () {
              controller.listenFilterCategory(categories[index]);
            },
            child: Container(
              color: controller.checkFilterCategoryClicked(categories[index])
                  ? Theme.of(context).buttonColor
                  : lightGreyColor,
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.smallSpace(),
                vertical: _appConfig.extraSmallSpace(),
              ),
              child: Text(
                categories[index],
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color:
                        controller.checkFilterCategoryClicked(categories[index])
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
