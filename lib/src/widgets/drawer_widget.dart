import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/widgets/widget.dart';

import '../route/generated_route.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    Key key,
    @required this.scaffoldKey,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _functions = Functions();

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              if (currentUser.value.apiToken != null) {
                Navigator.of(context)
                    .pushReplacementNamed(homeRoute, arguments: 3);
              } else {
                final message = await Navigator.of(context)
                    .pushReplacementNamed(loginRoute);
                _functions.showMessageWithAction(
                    widget.scaffoldKey, context, message);
              }
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
              ),
              currentAccountPicture: currentUser.value.auth
                  ? ProfilePicture()
                  : Icon(
                      Icons.person,
                      size: _appConfig.appBarIconSize(),
                      color: Theme.of(context).accentColor.withOpacity(1),
                    ),
              accountName: Text(
                currentUser.value.auth
                    ? currentUser.value.name
                    : LocaleKeys.guest.tr(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              accountEmail: Text(
                currentUser.value.auth ? currentUser.value.email : '',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          DrawerItem(
            icon: Icons.notifications,
            title: LocaleKeys.menu_notifications,
            routeName: homeRoute,
            argument: 2,
          ),
          DrawerItem(
            icon: Icons.fastfood,
            title: LocaleKeys.menu_my_orders,
            routeName: myOrderRoute,
          ),
          DrawerItem(
            icon: Icons.favorite,
            title: LocaleKeys.menu_favorite_foods,
            routeName: wishlistRoute,
          ),
          ListTile(
            dense: true,
            title: Text(
              LocaleKeys.menu_app_preferences.tr(),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          DrawerItem(
            icon: Icons.help,
            title: LocaleKeys.menu_help_support,
            routeName: helpRoute,
          ),
          DrawerItem(
            icon: Icons.settings,
            title: LocaleKeys.menu_settings,
            routeName: settingRoute,
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({
    Key key,
    this.title,
    this.icon,
    this.routeName,
    this.argument,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String routeName;
  final dynamic argument;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushReplacementNamed(routeName, arguments: argument);
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
      ),
      leading: Icon(
        icon,
        size: _appConfig.appBarIconSize(),
      ),
      title: Text(
        title.tr(),
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
