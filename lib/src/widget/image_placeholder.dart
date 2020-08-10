import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

class ImagePlaceHolder extends StatelessWidget {
  ImagePlaceHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(_appConfig.borderRadius()),
      child: Image.asset(
        AppImages.noProductBackground,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
