import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

class FoodDescriptionWidget extends StatelessWidget {
  FoodDescriptionWidget({
    Key key,
    @required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
        children: <TextSpan>[
          HTML.toTextSpan(
            context,
            description,
            defaultTextStyle:
                Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
