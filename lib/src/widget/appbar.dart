import 'package:flutter/material.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';

class HomeAppbar extends StatelessWidget with PreferredSizeWidget {
  HomeAppbar({
    Key key,
    @required this.title,
    @required this.openDrawer,
  });

  final String title;
  final VoidCallback openDrawer;

  final double height = 60.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.sort, color: Theme.of(context).buttonColor),
        onPressed: openDrawer,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: Theme.of(context).buttonColor,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class Appbar extends StatelessWidget with PreferredSizeWidget {
  Appbar({
    Key key,
    this.title,
    this.onBackPressed,
  });
  final String title;
  final VoidCallback onBackPressed;

  final double height = 60.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: Theme.of(context).iconTheme,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 15.0,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          if (onBackPressed == null)
            Navigator.of(context).pop();
          else
            onBackPressed();
        },
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
      actions: [
        Container(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class SliverAppbar extends StatelessWidget with PreferredSizeWidget {
  SliverAppbar({
    Key key,
    @required this.title,
    @required this.isShrink,
    @required this.cartCount,
  });

  final String title;
  final bool isShrink;
  final int cartCount;

  final double height = 60.0;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor:
          isShrink ? Theme.of(context).primaryColor : Colors.transparent,
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: isShrink ? Theme.of(context).accentColor : whiteColor,
          ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: isShrink ? Theme.of(context).accentColor : whiteColor,
            ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(_appConfig.extraSmallSpace()),
                child: Icon(
                  AppIcons.ic_cart,
                  size: _appConfig.appBarIconSize(),
                  color: isShrink ? Theme.of(context).accentColor : whiteColor,
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
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
            ],
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              homeRoute,
              (Route<dynamic> route) => false,
              arguments: {arg_current_tab: 1},
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
