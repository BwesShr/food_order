import 'package:flutter/material.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class NavBarCartIcon extends StatelessWidget {
  NavBarCartIcon({
    Key key,
    @required this.cartCount,
    @required this.currentTab,
  }) : super(key: key);

  final int cartCount;
  final int currentTab;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_appConfig.extraSmallSpace()),
          child: Icon(
            AppIcons.ic_cart,
            size: _appConfig.navBarIconSize(),
            color: currentTab == 1
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
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
                    color: currentTab == 1
                        ? secondaryColor
                        : Theme.of(context).primaryColor,
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
