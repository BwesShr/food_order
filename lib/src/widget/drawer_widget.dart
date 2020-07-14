import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/repository/settings_repo.dart';
import 'package:food_order/src/repository/user_repo.dart' as userRepo;
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/custom_text_style.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/utils/local_strings.dart';
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
              title: guest,
              onPressed: () {},
            ),
          ),
          DrawerItem(
            icon: AppIcons.ic_home,
            title: menu_home,
            onPressed: () {
              Navigator.of(context).pushNamed(homeRoute, arguments: 2);
            },
          ),
          DrawerItem(
            icon: Icons.notifications,
            title: menu_notifications,
            onPressed: () {
              Navigator.of(context).pushNamed(homeRoute, arguments: 0);
            },
          ),
          DrawerItem(
            icon: Icons.fastfood,
            title: menu_my_orders,
            onPressed: () {
              Navigator.of(context).pushNamed(homeRoute, arguments: 3);
            },
          ),
          DrawerItem(
            icon: Icons.favorite,
            title: menu_favorite_foods,
            onPressed: () {
              Navigator.of(context).pushNamed(homeRoute, arguments: 4);
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              menu_app_preferences,
              style: CustomTextStyle.menuTitleTextStyle(context),
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).accentColor,
            ),
          ),
          DrawerItem(
            icon: Icons.help,
            title: menu_help_support,
            onPressed: () {
              Navigator.of(context).pushNamed('/Help');
            },
          ),
          DrawerItem(
            icon: Icons.settings,
            title: menu_settings,
            onPressed: () {
              if (userRepo.currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed(settingRoute);
              } else {
                Navigator.of(context).pushReplacementNamed(loginRoute);
              }
            },
          ),
          DrawerItem(
            icon: Icons.translate,
            title: menu_languages,
            onPressed: () {
              Navigator.of(context).pushNamed(languageRoute);
            },
          ),
          DrawerItem(
            icon: Icons.brightness_6,
            title: Theme.of(context).brightness == Brightness.dark
                ? menu_light_mode
                : menu_dark_mode,
            onPressed: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                setBrightness(Brightness.light);
                DynamicTheme.of(context).setBrightness(Brightness.light);
              } else {
                setBrightness(Brightness.dark);
                DynamicTheme.of(context).setBrightness(Brightness.dark);
              }
            },
          ),
          DrawerItem(
            icon: Icons.exit_to_app,
            title: userRepo.currentUser.value.apiToken != null
                ? menu_login
                : menu_login,
            onPressed: () {
              if (userRepo.currentUser.value.apiToken != null) {
                userRepo.logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute, (Route<dynamic> route) => false,
                      arguments: 2);
                });
              } else {
                Navigator.of(context).pushNamed(loginRoute);
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
          horizontal: _appConfig.horizontalPadding(5), vertical: 0.0),
      leading: IconTheme(
        data: Theme.of(context).iconTheme,
        child: Icon(
          icon,
          color: Theme.of(context).accentColor,
        ),
      ),
      title: Text(
        title,
        style: CustomTextStyle.menuTextStyle(context),
      ),
    );
  }
}
