import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/route/generated_route.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({
    Key key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(searchRoute);
      },
      child: Container(
        color: Theme.of(context).hintColor.withAlpha(8000),
        margin: EdgeInsets.symmetric(
          horizontal: _appConfig.horizontalSpace(),
          vertical: _appConfig.verticalSpace(),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _appConfig.horizontalSpace(),
          vertical: _appConfig.verticalSpace(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              LocaleKeys.hint_search_foods.tr(),
              style: Theme.of(context).textTheme.caption,
            ),
            Icon(
              AppIcons.ic_search,
              size: _appConfig.searchIconSize(),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
