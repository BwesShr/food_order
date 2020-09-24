import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AppConfig {
  BuildContext _context;
  static double _width;
  static double _height;
  static double _widthPadding;
  static double _heightPadding;

  AppConfig(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  Radius borderRadius() {
    return Radius.circular(25);
  }

  BoxShadow containerShadow() {
    return BoxShadow(
      color: AppColors.greyColor.withOpacity(0.1),
      blurRadius: 5,
      offset: Offset(0, 2),
    );
  }

  double appBarIconSize() => 30;

  double searchIconSize() => 25;

  double buttonIconSize() => 20;

  double navBarIconSize() => 30;

  double sliverImageHeight() => _height * 60;

  double horizontalSpace() => _widthPadding * 6;

  double verticalSpace() => _heightPadding * 2;

  double extraSmallSpace() => _height * 1;

  double smallSpace() => _height * 2;

  double bigSpace() => _heightPadding * 3;

  double hugeSpace() => _heightPadding * 5;

  double appHeight(double v) => _height * v;

  double textSize(double v) => _width * v;

  double appWidth(double v) => _width * v;

  double verticalPadding(double v) => _heightPadding * v;

  double horizontalPadding(double v) => _widthPadding * v;

  int gridItemCount() {
    double width = appWidth(100);
    double height = appHeight(600);
    int itemInSingleHeight = (height / (width * 0.5)).toInt();
    return itemInSingleHeight * 2;
  }
}

// class AppColors {
//   Color _mainColor = Color(0xFFFFFFFF);
//   Color _mainDarkColor = Color(0xFFe3E3E3E);
//   Color _secondColor = Color(0xFF808080);
//   Color _secondDarkColor = Color(0xFFA3A3A3);
//   Color _accentColor = Color(0xFFD2D2D2);
//   Color _accentDarkColor = Color(0xFFEAEAEA);
//   Color _buttonColor = Color(0xFFFF5656);
//   Color _sbuttonSecondaryColor = Color(0xFFF1F1F1);

//   Color mainColor(double opacity) {
//     try {
//       return Color(int.parse(
//               settingRepo.setting.value.mainColor.replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }

//   Color secondColor(double opacity) {
//     try {
//       return Color(int.parse(
//               settingRepo.setting.value.secondColor.replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }

//   Color accentColor(double opacity) {
//     try {
//       return Color(int.parse(
//               settingRepo.setting.value.accentColor.replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }

//   Color mainDarkColor(double opacity) {
//     try {
//       return Color(int.parse(
//               settingRepo.setting.value.mainDarkColor.replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }

//   Color secondDarkColor(double opacity) {
//     try {
//       return Color(int.parse(settingRepo.setting.value.secondDarkColor
//               .replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }

//   Color accentDarkColor(double opacity) {
//     try {
//       return Color(int.parse(settingRepo.setting.value.accentDarkColor
//               .replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }

//   Color scaffoldColor(double opacity) {
//     // TODO test if brightness is dark or not
//     try {
//       return Color(int.parse(
//               settingRepo.setting.value.scaffoldColor.replaceAll("#", "0xFF")))
//           .withOpacity(opacity);
//     } catch (e) {
//       return Color(0xFFCCCCCC).withOpacity(opacity);
//     }
//   }
// }
