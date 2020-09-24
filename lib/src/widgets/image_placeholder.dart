import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

class ImagePlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(_appConfig.borderRadius()),
        child: Image.asset(
          AppImages.noProductBackground,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
