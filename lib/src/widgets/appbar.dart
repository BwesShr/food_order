import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/route/generated_route.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

import 'food/cart/appbar_cart_icon.dart';

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
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.sort),
        onPressed: openDrawer,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
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
      centerTitle: true,
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
            color:
                isShrink ? Theme.of(context).accentColor : AppColors.whiteColor,
          ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: isShrink
                  ? Theme.of(context).accentColor
                  : AppColors.whiteColor,
            ),
      ),
      actions: <Widget>[
        IconButton(
          icon: AppBarCartIcon(
            cartCount: cartCount,
            isShrink: isShrink,
          ),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            homeRoute,
            (Route<dynamic> route) => false,
            arguments: 1,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
