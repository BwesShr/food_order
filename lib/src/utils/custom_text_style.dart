import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:flutter/material.dart';

import 'color_theme.dart';

class CustomTextStyle {
  static TextStyle menuTextStyle(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Theme.of(context).textTheme.headline3.copyWith(
          color: menuItemColor,
          fontSize: _appConfig.textSize(4),
        );
  }

  static TextStyle menuTitleTextStyle(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Theme.of(context).textTheme.headline3.copyWith(
          color: menuItemColor,
          fontSize: _appConfig.textSize(5),
        );
  }
}
