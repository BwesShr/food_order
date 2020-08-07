import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flag/flag.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/repository/settings_repo.dart';
import 'package:food_order/src/repository/user_repo.dart' as userRepo;
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  // ProfileController _con;
  final _saveData = SaveData();
  final _functions = Functions();

  // _DrawerWidgetState() : super(ProfileController()) {
  //   _con = controller;
  // }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: DrawerItem(
              icon: Icons.person,
              title: LocaleKeys.guest,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(homeRoute,
                    arguments: {arg_current_tab: 3});
              },
            ),
          ),
          DrawerItem(
            icon: Icons.notifications,
            title: LocaleKeys.menu_notifications,
            onPressed: () {
              Navigator.of(context).pushNamed(notificationRoute, arguments: 0);
            },
          ),
          DrawerItem(
            icon: Icons.fastfood,
            title: LocaleKeys.menu_my_orders,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(homeRoute,
                  arguments: {arg_current_tab: 2});
            },
          ),
          DrawerItem(
            icon: Icons.favorite,
            title: LocaleKeys.menu_favorite_foods,
            onPressed: () {
              Navigator.of(context).pushNamed(favFoodRoute);
            },
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
            onPressed: () {
              Navigator.of(context).pushNamed(helpRoute);
            },
          ),
          DrawerItem(
            icon: Icons.settings,
            title: LocaleKeys.menu_settings,
            onPressed: () {
              if (userRepo.currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed(settingRoute);
              } else {
                Navigator.of(context).pushReplacementNamed(loginRoute);
              }
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(languageRoute);
            },
            contentPadding: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalSpace(),
            ),
            leading: Flag(
              Localizations.localeOf(context).countryCode.toLowerCase(),
              width: _appConfig.appBarIconSize(),
              height: _appConfig.appBarIconSize(),
            ),
            title: Text(
              LocaleKeys.menu_languages.tr(),
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Theme.of(context).buttonColor,
                  ),
            ),
          ),
          DrawerItem(
            icon: Icons.brightness_6,
            title: Theme.of(context).brightness == Brightness.dark
                ? LocaleKeys.menu_light_mode
                : LocaleKeys.menu_dark_mode,
            onPressed: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                setBrightness(Brightness.light);
                DynamicTheme.of(context).setBrightness(Brightness.light);
                Navigator.of(context).pop();
              } else {
                setBrightness(Brightness.dark);
                DynamicTheme.of(context).setBrightness(Brightness.dark);
                Navigator.of(context).pop();
              }
            },
          ),
          DrawerItem(
            icon: Icons.exit_to_app,
            title: userRepo.currentUser.value.apiToken == null
                ? LocaleKeys.menu_login
                : LocaleKeys.menu_logout,
            onPressed: () {
              if (userRepo.currentUser.value.apiToken == null) {
                Navigator.of(context).pushNamed(loginRoute);
              } else {
                userRepo.logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute, (Route<dynamic> route) => false,
                      arguments: {arg_current_tab: 0});
                });
              }
            },
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
    this.onPressed,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
      ),
      leading: Icon(
        icon,
        size: _appConfig.appBarIconSize(),
        color: Theme.of(context).buttonColor,
      ),
      title: Text(
        title.tr(),
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: Theme.of(context).buttonColor,
            ),
      ),
    );
  }
}
