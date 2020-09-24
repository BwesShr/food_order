import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/controller/search_controller.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as slider;

typedef SliderChangedCallback(double lowerValue, double upperValue);

class PriceRangeSlider extends StatelessWidget {
  PriceRangeSlider({
    Key key,
    @required this.controller,
    @required this.onValueChanged,
  }) : super(key: key);

  final SearchController controller;
  final SliderChangedCallback onValueChanged;

  @override
  Widget build(BuildContext context) {
    return slider.RangeSlider(
      min: controller.lowerValue,
      max: controller.upperValue,
      lowerValue: controller.filterLowerValue,
      upperValue: controller.filterUpperValue,
      divisions: 5,
      showValueIndicator: true,
      valueIndicatorMaxDecimals: 1,
      onChanged: onValueChanged,
      onChangeStart: onValueChanged,
      onChangeEnd: onValueChanged,
    );
  }
}
