import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppImages {
  static String appIcon = 'assets/images/logo.png';
  static String noProductBackground = 'assets/background/no-image.png';
}

class AppColors {
  static const primaryColor = Color(0xFFFAA61A);
  static const secondaryColor = Color(0xFFC62D29);

  static const backgroundColor = Color(0xFFF7F8FA);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF212121);
  static const greyColor = Colors.grey;
  static const dividerColor = Color(0xFFE4E4E4);
  static const blackTransparentColor = Color(0xF65000000);
}

class Constants {
  // address type
  static const addressTypeWork = 'work';
  static const addressTypeHome = 'home';

  // cash payment method
  static const paymentCashOnDelivery = 'cash_on_delivery';
  static const paymentCashOnPickup = 'cash_on_pickup';
}
