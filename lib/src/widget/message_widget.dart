import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

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
            horizontal: _appConfig.horizontalPadding(6),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: _appConfig.horizontalPadding(40.0),
                ),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.grey,
                        fontSize: 25.0,
                      ),
                ),
              ),
              SizedBox(height: _appConfig.appHeight(15)),
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
