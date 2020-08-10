import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';

class UserAddressWidget extends StatelessWidget {
  UserAddressWidget({
    Key key,
    @required this.icon,
    @required this.fullName,
    @required this.address,
    @required this.onChangeAddressPressed,
    this.isDefault = false,
  }) : super(key: key);

  final IconData icon;
  final String fullName;
  final String address;
  final VoidCallback onChangeAddressPressed;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _appConfig.horizontalSpace(),
          vertical: _appConfig.verticalSpace()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).buttonColor,
              ),
              SizedBox(width: _appConfig.extraSmallSpace()),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      fullName,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      address,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              SizedBox(width: _appConfig.extraSmallSpace()),
              GestureDetector(
                onTap: onChangeAddressPressed,
                child: Text(
                  LocaleKeys.action_change.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Theme.of(context).buttonColor),
                ),
              ),
            ],
          ),
          isDefault
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).buttonColor,
                    ),
                    borderRadius: BorderRadius.all(_appConfig.borderRadius()),
                  ),
                  margin: EdgeInsets.only(top: _appConfig.extraSmallSpace()),
                  padding: EdgeInsets.all(_appConfig.horizontalPadding(1)),
                  child: Text(
                    LocaleKeys.make_default_address.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Theme.of(context).buttonColor),
                  ),
                )
              : Offstage(),
        ],
      ),
    );
  }
}
