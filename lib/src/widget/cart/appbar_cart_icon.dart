import 'package:flutter/material.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class AppBarCartIcon extends StatelessWidget {
  AppBarCartIcon({
    Key key,
    @required this.cartCount,
    @required this.isShrink,
  }) : super(key: key);

  final int cartCount;
  final bool isShrink;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_appConfig.extraSmallSpace()),
          child: Icon(
            AppIcons.ic_cart,
            size: _appConfig.appBarIconSize(),
            color: isShrink ? Theme.of(context).accentColor : whiteColor,
          ),
        ),
        cartCount == null
            ? Offstage()
            : Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.all(
                    _appConfig.horizontalPadding(0.5),
                  ),
                  decoration: BoxDecoration(
                    color: isShrink
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(_appConfig.appWidth(1)),
                    child: Text(
                      cartCount.toString(),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: whiteColor,
                            fontSize: 10.0,
                          ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
