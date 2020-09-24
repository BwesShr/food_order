import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/controller/search_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

class FilterTypes extends StatelessWidget {
  FilterTypes({
    Key key,
    @required this.controller,
    @required this.types,
  }) : super(key: key);

  final SearchController controller;
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Wrap(
      spacing: _appConfig.horizontalPadding(2),
      runSpacing: _appConfig.verticalPadding(2),
      children: List.generate(
        types.length,
        (index) {
          return InkWell(
            onTap: () {
              controller.listenFilterType(types[index]);
            },
            child: Container(
              color: controller.checkFilterTypeClicked(types[index])
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).hintColor.withAlpha(8000),
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.smallSpace(),
                vertical: _appConfig.extraSmallSpace(),
              ),
              child: Text(
                types[index],
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: controller.checkFilterTypeClicked(types[index])
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
