import 'package:flutter/material.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';

class NavBarIconWidget extends StatelessWidget {
  NavBarIconWidget({
    Key key,
    @required this.currentTab,
    @required this.cartCount,
  }) : super(key: key);

  final int currentTab;
  final int cartCount;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    double size = _appConfig.navBarIconSize();

    return ListView(
      children: <Widget>[
        buildIcon(context, size, AppIcons.ic_home, 0),
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(_appConfig.extraSmallSpace()),
              child: buildIcon(context, size, AppIcons.ic_cart, 1),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.all(
                  _appConfig.horizontalPadding(0.5),
                ),
                decoration: BoxDecoration(
                  color: currentTab == 1 ? secondaryColor : whiteColor,
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
        ),
        buildIcon(context, size, AppIcons.ic_history, 2),
        buildIcon(context, size, AppIcons.ic_profile, 3),
      ],
    );
  }

  Icon buildIcon(BuildContext context, double size, IconData icon, int index) {
    return Icon(
      icon,
      color: currentTab == index
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      size: size,
    );
  }
}
