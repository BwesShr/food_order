import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/functions.dart';

class AmountWidget extends StatelessWidget {
  AmountWidget({
    Key key,
    @required this.food,
    @required this.textStyle,
  }) : super(key: key);

  final Food food;
  final TextStyle textStyle;

  final _functions = Functions();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: textStyle.copyWith(
          color: Theme.of(context).buttonColor,
        ),
        children: <TextSpan>[
          (food.discount != 0)
              ? TextSpan(
                  text: LocaleKeys.amount_unit.tr(namedArgs: {
                    'amount': '${_functions.getDiscountedPrice(food)}'
                  }),
                )
              : TextSpan(text: ''),
          TextSpan(text: (food.discount != 0) ? '  ' : ''),
          TextSpan(
            text: LocaleKeys.amount_unit
                .tr(namedArgs: {'amount': '${food.price.toStringAsFixed(2)}'}),
            style: textStyle.copyWith(
              color: (food.discount != 0)
                  ? Theme.of(context).accentColor.withOpacity(0.3)
                  : Theme.of(context).buttonColor,
            ),
          ),
        ],
      ),
    );
  }
}
