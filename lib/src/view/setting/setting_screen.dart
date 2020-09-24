import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';

import '../../route/generated_route.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Scaffold(
      appBar: Appbar(
        title: LocaleKeys.menu_settings.tr(),
        onBackPressed: _onBackPressed,
      ),
      body: ListView(
        children: <Widget>[
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
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                setBrightness(Brightness.light);
                DynamicTheme.of(context).setBrightness(Brightness.light);
              } else {
                setBrightness(Brightness.dark);
                DynamicTheme.of(context).setBrightness(Brightness.dark);
              }
            },
            contentPadding: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalSpace(),
            ),
            leading: Icon(
              Icons.brightness_6,
              size: _appConfig.appBarIconSize(),
            ),
            title: Text(
              Theme.of(context).brightness == Brightness.dark
                  ? LocaleKeys.menu_light_mode.tr()
                  : LocaleKeys.menu_dark_mode.tr(),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
