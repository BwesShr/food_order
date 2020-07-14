import 'package:connectivity/connectivity.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:food_order/src/model/setting.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/repository/settings_repo.dart' as settingRepo;
import 'src/route_generator.dart';
import 'src/utils/color_theme.dart';
import 'src/utils/local_strings.dart';
import 'src/utils/my_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _saveData = SaveData();

  // MyApp({Key key}) : super(con: Controller(), key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: settingRepo.getAppTheme() != null
          ? Brightness.dark
          : Brightness.light,
      data: (brightness) {
        if (brightness == Brightness.light) {
          return ThemeData(
            fontFamily: 'AppFont',
            brightness: Brightness.light,
            scaffoldBackgroundColor: whiteColor,
            backgroundColor: whiteColor,
            primaryColor: whiteColor,
            accentColor: accentColor,
            hintColor: hintColor,
            buttonColor: btnPrimaryColor,
            focusColor: btnFocusColor,
            iconTheme: IconThemeData(color: btnPrimaryColor),
            buttonTheme: ButtonThemeData(
              buttonColor: btnPrimaryColor,
              focusColor: btnFocusColor,
              hoverColor: btnFocusColor,
              disabledColor: btnFocusColor,
              splashColor: btnSplashColor,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              headline2: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 16.0,
              ),
              button: TextStyle(
                color: secondaryTextColor,
                fontWeight: FontWeight.w800,
              ),
              bodyText1: TextStyle(
                fontSize: 18.0,
              ),
              bodyText2: TextStyle(
                fontSize: 16.0,
              ),
              caption: TextStyle(
                fontSize: 12.0,
                color: subTextColor,
              ),
            ),
          );
        } else {
          return ThemeData(
            fontFamily: 'AppFont',
            primaryColor: blackColor,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: blackColor,
            backgroundColor: blackColor,
            accentColor: accentColor,
            hintColor: hintColor,
            buttonColor: btnPrimaryColor,
            focusColor: btnFocusColor,
            iconTheme: IconThemeData(color: btnPrimaryColor),
            buttonTheme: ButtonThemeData(
              buttonColor: btnPrimaryColor,
              focusColor: btnFocusColor,
              hoverColor: btnFocusColor,
              disabledColor: btnFocusColor,
              splashColor: btnSplashColor,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 20.0,
              ),
              headline2: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              button: TextStyle(
                color: btnSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
              bodyText1: TextStyle(
                fontSize: 16.0,
              ),
              bodyText2: TextStyle(
                fontSize: 14.0,
              ),
              caption: TextStyle(
                fontSize: 12.0,
                color: subTextColor,
              ),
            ),
          );
        }
      },
      themedWidgetBuilder: (context, theme) {
        return ValueListenableBuilder(
          valueListenable: settingRepo.setting,
          builder: (context, Setting _setting, _) {
            return MaterialApp(
              title: app_name,
              initialRoute: splashRoute,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,
              locale: Locale('en', ''),
              localizationsDelegates: [
                MyLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', ''),
                const Locale('ne', ''),
              ],
              theme: theme,
            );
          },
        );
      },
    );
  }
}
