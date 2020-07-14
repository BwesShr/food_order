import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "app_name": "Food Delivery",
      "menu_guest": "Guest",
      "menu_home": "Home",
      "menu_notifications": "Notifications",
      "menu_my_orders": "My Orders",
      "menu_favorite_foods": "Favorite Foods",
      "menu_app_preferences": "Application Preferences",
      "menu_help_support": "Help Support",
      "menu_settings": "Settings",
      "menu_languages": "Languages",
      "menu_light_mode": "Light Mode",
      "menu_dark_mode": "Dark Mode",
      "menu_login": "Login",
      "menu_logout": "Logout"
    },
    'ne': {
      "app_name": "Food Delivery",
      "menu_guest": "Guest",
      "menu_home": "Home",
      "menu_notifications": "Notifications",
      "menu_my_orders": "My Orders",
      "menu_favorite_foods": "Favorite Foods",
      "menu_app_preferences": "Application Preferences",
      "menu_help_support": "Help Support",
      "menu_settings": "Settings",
      "menu_languages": "Languages",
      "menu_light_mode": "Light Mode",
      "menu_dark_mode": "Dark Mode",
      "menu_login": "Login",
      "menu_logout": "Logout"
    }
  };

  String translate(key) {
    return _localizedValues[locale.languageCode][key];
  }

  static String of(BuildContext context, String key) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations)
        .translate(key);
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ne'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
