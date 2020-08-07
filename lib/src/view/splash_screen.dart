import 'package:food_order/src/controller/splash_screen_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _controller;

  _SplashScreenState() : super(SplashScreenController()) {
    _controller = controller;
  }

  @override
  void initState() {
    super.initState();

    _controller.changePage();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Scaffold(
      key: _controller.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                appIcon,
                width: _appConfig.appWidth(40),
                fit: BoxFit.cover,
              ),
              SizedBox(height: _appConfig.hugeSpace()),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
