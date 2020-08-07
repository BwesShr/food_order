import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/model/setting.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'src/controller/controller.dart';
import 'src/repository/settings_repo.dart' as settingRepo;
import 'src/route_generator.dart';
import 'src/utils/color_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en', 'US'), Locale('ne', 'NP')],
    path: 'assets/translations/locales.csv',
    fallbackLocale: Locale('en', 'US'),
    useOnlyLangCode: false,
    assetLoader: CsvAssetLoader(),
  ));
}

class MyApp extends AppMVC {
  MyApp({Key key}) : super(con: Controller(), key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) {
        if (brightness == Brightness.light) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: whiteColor,
            systemNavigationBarIconBrightness: Brightness.dark,
          ));
          return ThemeData(
            fontFamily: 'AppFont',
            brightness: Brightness.light,
            scaffoldBackgroundColor: backgroundColor,
            backgroundColor: backgroundColor,
            primaryColor: whiteColor,
            accentColor: blackColor,
            hintColor: greyColor,
            cursorColor: blackColor,
            buttonColor: primaryColor,
            splashColor: greyColor.withOpacity(0.5),
            focusColor: greyColor.withOpacity(0.5),
            iconTheme: IconThemeData(
              color: blackColor,
              size: 15.0,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: primaryColor,
              focusColor: greyColor,
              hoverColor: greyColor,
              disabledColor: greyColor,
              splashColor: greyColor,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 25.0,
                color: blackColor,
                fontWeight: FontWeight.w700,
              ),
              headline2: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 16.0,
              ),
              button: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.w500,
              ),
              bodyText1: TextStyle(
                fontSize: 18.0,
              ),
              bodyText2: TextStyle(
                fontSize: 16.0,
              ),
              caption: TextStyle(
                fontSize: 12.0,
                color: greyColor,
              ),
            ),
          );
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: blackColor,
            systemNavigationBarIconBrightness: Brightness.light,
          ));
          return ThemeData(
            fontFamily: 'AppFont',
            primaryColor: blackColor,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: blackColor,
            backgroundColor: blackColor,
            accentColor: whiteColor,
            hintColor: greyColor,
            cursorColor: whiteColor,
            buttonColor: primaryColor,
            splashColor: greyColor.withOpacity(0.3),
            focusColor: greyColor.withOpacity(0.3),
            iconTheme: IconThemeData(
              color: whiteColor,
              size: 15.0,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: primaryColor,
              focusColor: greyColor,
              hoverColor: greyColor,
              disabledColor: greyColor,
              splashColor: greyColor,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 20.0,
                color: whiteColor,
                fontWeight: FontWeight.w700,
              ),
              headline2: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 16.0,
              ),
              button: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.w500,
              ),
              bodyText1: TextStyle(
                fontSize: 16.0,
              ),
              bodyText2: TextStyle(
                fontSize: 14.0,
              ),
              caption: TextStyle(
                fontSize: 12.0,
                color: greyColor,
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
              title: LocaleKeys.app_name.tr(),
              initialRoute: splashRoute,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: theme,
            );
          },
        );
      },
    );
  }
}
