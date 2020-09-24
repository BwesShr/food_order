import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

import 'buttons/primary_button.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({
    Key key,
    @required this.message,
    @required this.buttonText,
    @required this.onButtonClicked,
  }) : super(key: key);

  final String message;
  final String buttonText;
  final VoidCallback onButtonClicked;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(
            horizontal: _appConfig.horizontalSpace(),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Image.asset(
                AppImages.appIcon,
                height: _appConfig.appHeight(20),
              ),
              SizedBox(height: _appConfig.smallSpace()),
              Padding(
                padding: EdgeInsets.only(
                  right: _appConfig.horizontalPadding(30.0),
                ),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              SizedBox(height: _appConfig.smallSpace()),
              PrimaryButton(
                text: buttonText,
                onPressed: onButtonClicked,
              ),
              SizedBox(height: _appConfig.hugeSpace()),
            ],
          ),
        ),
      ),
    );
  }
}
