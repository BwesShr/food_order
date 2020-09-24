import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';

import 'buttons/primary_button.dart';

class CheckoutFooter extends StatelessWidget {
  CheckoutFooter({
    Key key,
    @required this.deliveryFee,
    @required this.vat,
    @required this.total,
    @required this.buttonText,
    @required this.onButtonClick,
  }) : super(key: key);

  final String deliveryFee;
  final String vat;
  final String total;
  final String buttonText;
  final VoidCallback onButtonClick;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: _appConfig.horizontalSpace()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.caption,
                  children: <TextSpan>[
                    TextSpan(
                      text: LocaleKeys.delivery_amount_unit.tr(),
                    ),
                    TextSpan(
                      text: ': ',
                    ),
                    TextSpan(
                      text: LocaleKeys.amount_unit
                          .tr(namedArgs: {'amount': deliveryFee}),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).buttonColor,
                          ),
                    ),
                    TextSpan(
                      text: '  ',
                    ),
                    TextSpan(
                      text: LocaleKeys.vat_included_unit
                          .tr(namedArgs: {'vat': vat}),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: LocaleKeys.total_unit.tr(),
                    ),
                    TextSpan(
                      text: ': ',
                    ),
                    TextSpan(
                      text: LocaleKeys.amount_unit
                          .tr(namedArgs: {'amount': total}),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).buttonColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          PrimaryButton(
            width: _appConfig.appWidth(30),
            text: buttonText,
            onPressed: onButtonClick,
          ),
        ],
      ),
    );
  }
}
