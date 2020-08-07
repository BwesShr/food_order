import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/model/food.dart';
import 'package:simple_html_css/simple_html_css.dart';

class FoodDescriptionWidget extends StatelessWidget {
  FoodDescriptionWidget({
    Key key,
    @required this.food,
    @required this.excerpt,
    @required this.onExcerptPressed,
  }) : super(key: key);

  final Food food;
  final bool excerpt;
  final VoidCallback onExcerptPressed;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
        children: <TextSpan>[
          HTML.toTextSpan(
            context,
            excerpt ? food.excerpt : food.description,
            defaultTextStyle:
                Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
          ),
          TextSpan(text: excerpt ? '... ' : ''),
          TextSpan(
            text: excerpt ? LocaleKeys.action_readmore.tr() : '',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).buttonColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onExcerptPressed(),
          ),
        ],
      ),
    );
  }
}
