import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/controller/search_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

import 'buttons/primary_button.dart';
import 'buttons/secondary_button.dart';
import 'search/filter_categories.dart';
import 'search/filter_type.dart';
import 'search/price_range_slider.dart';

class FilterDrawerWidget extends StatefulWidget {
  FilterDrawerWidget({
    Key key,
    @required this.controller,
    @required this.categories,
    @required this.types,
    @required this.onApplyPressed,
  }) : super(key: key);

  final SearchController controller;
  final List<String> categories;
  final List<String> types;
  final VoidCallback onApplyPressed;

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Drawer(
      elevation: 10.0,
      child: Column(
        children: <Widget>[
          ListTile(
            dense: true,
            title: Text(
              LocaleKeys.title_filter.tr(),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalSpace(),
                vertical: _appConfig.verticalSpace(),
              ),
              child: ListView(
                children: <Widget>[
                  Text(
                    LocaleKeys.filter_category.tr(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: _appConfig.smallSpace()),
                  FilterCategories(
                    controller: widget.controller,
                    categories: widget.categories,
                  ),
                  SizedBox(height: _appConfig.hugeSpace()),
                  Text(
                    LocaleKeys.filter_food_type.tr(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: _appConfig.smallSpace()),
                  FilterTypes(
                    controller: widget.controller,
                    types: widget.types,
                  ),
                  SizedBox(height: _appConfig.hugeSpace()),
                  Text(
                    LocaleKeys.filter_price_range.tr(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  PriceRangeSlider(
                    controller: widget.controller,
                    onValueChanged: (lowerValue, upperValue) {
                      setState(() {
                        widget.controller.filterLowerValue = lowerValue;
                        widget.controller.filterUpperValue = upperValue;
                      });
                    },
                  ),
                  SizedBox(height: _appConfig.hugeSpace()),
                ],
              ),
            ),
          ),
          PrimaryButton(
            width: _appConfig.appWidth(70),
            text: LocaleKeys.action_apply_filter.tr(),
            onPressed: () {
              Navigator.of(context).pop();
              widget.onApplyPressed();
            },
          ),
          SecondaryButton(
            width: _appConfig.appWidth(70),
            text: LocaleKeys.action_clear_filter.tr(),
            onPressed: () {
              setState(() {
                widget.controller.clearFilterData();
              });
              // Navigator.of(context).pop();
            },
          ),
          SizedBox(height: _appConfig.verticalSpace()),
        ],
      ),
    );
  }
}
