import 'package:food_order/src/controller/splash_screen_controller.dart';
import 'package:food_order/src/utils/images.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;
  final _saveData = SaveData();

  _SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() {
    _con.changePage();
    // _con.progress.addListener(() {
    //   double progress = 0;

    //   print('progress: $progress');
    //   _con.progress.value.values.forEach((_progress) {
    //     print('progress: $progress');
    //     progress += _progress;
    //   });
    //   if (progress == 100) {
    //     Navigator.of(context).pushReplacementNamed(walkThroughRoute);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
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
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
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
