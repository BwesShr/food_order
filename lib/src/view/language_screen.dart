import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widget/appbar.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Scaffold(
      appBar: Appbar(
        title: LocaleKeys.language_title.tr(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: _appConfig.horizontalSpace(),
          vertical: _appConfig.verticalSpace(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTileMenuItem(
                leading: 'us',
                title: LocaleKeys.language_en.tr(),
                subtitle: 'English',
                locale: EasyLocalization.of(context).supportedLocales[0]),
            buildDivider(),
            SwitchListTileMenuItem(
                leading: 'np',
                title: LocaleKeys.language_np.tr(),
                subtitle: 'Nepali',
                locale: EasyLocalization.of(context).supportedLocales[1]),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );
}

class SwitchListTileMenuItem extends StatelessWidget {
  SwitchListTileMenuItem({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.locale,
  });

  final String leading;
  final String title;
  final String subtitle;
  final Locale locale;
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return ListTile(
        contentPadding: EdgeInsets.all(0.0),
        dense: true,
        leading: Flag(
          leading,
          width: _appConfig.appWidth(15),
          height: _appConfig.appWidth(15),
        ),
        title: Text(
          title,
        ),
        subtitle: Text(
          subtitle,
        ),
        onTap: () {
          log(locale.toString(), name: toString());
          context.locale = locale; //BuildContext extension method
          //EasyLocalization.of(context).locale = locale;
          Navigator.pop(context);
        });
  }
}
