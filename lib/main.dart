import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'src/controller/controller.dart';
import 'src/models/model.dart';
import 'src/route/generated_route.dart';
import 'src/utils/constants.dart';

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
            systemNavigationBarColor: AppColors.whiteColor,
            systemNavigationBarDividerColor: AppColors.dividerColor,
            systemNavigationBarIconBrightness: Brightness.dark,
          ));
          return ThemeData(
            fontFamily: 'AppFont',
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.backgroundColor,
            backgroundColor: AppColors.backgroundColor,
            primaryColor: AppColors.whiteColor,
            accentColor: AppColors.blackColor,
            hintColor: AppColors.greyColor,
            cursorColor: AppColors.blackColor,
            buttonColor: AppColors.primaryColor,
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
            ),
            iconTheme: IconThemeData(
              color: AppColors.blackColor,
              size: 15.0,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 25.0,
                color: AppColors.blackColor,
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
                color: AppColors.whiteColor,
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
                color: AppColors.greyColor,
              ),
            ),
          );
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarDividerColor: AppColors.dividerColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.blackColor,
            systemNavigationBarIconBrightness: Brightness.light,
          ));
          return ThemeData(
            fontFamily: 'AppFont',
            primaryColor: AppColors.blackColor,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.blackColor,
            backgroundColor: AppColors.blackColor,
            accentColor: AppColors.whiteColor,
            hintColor: AppColors.greyColor,
            cursorColor: AppColors.whiteColor,
            buttonColor: AppColors.primaryColor,
            dividerColor: AppColors.dividerColor,
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
            ),
            iconTheme: IconThemeData(
              color: AppColors.whiteColor,
              size: 15.0,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 20.0,
                color: AppColors.whiteColor,
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
                color: AppColors.whiteColor,
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
                color: AppColors.greyColor,
              ),
            ),
          );
        }
      },
      themedWidgetBuilder: (context, theme) {
        return ValueListenableBuilder(
          valueListenable: appSetting,
          builder: (context, Setting _setting, _) {
            return MaterialApp(
              title: LocaleKeys.app_name.tr(),
              theme: theme,
              locale: context.locale,
              initialRoute: splashRoute,
              onGenerateRoute: generatedRoute,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
            );
          },
        );
      },
    );
  }
}
