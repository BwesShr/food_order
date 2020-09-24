import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/profile_controller.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateMVC<ProfileScreen> {
  ProfileController _controller;

  _ProfileScreenState() : super(ProfileController()) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return (!currentUser.value.auth)
        ? MessageWidget(
            message: LocaleKeys.subtitle_login_register.tr(),
            buttonText: LocaleKeys.action_login_register.tr(),
            onButtonClicked: _controller.userLogin,
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalSpace(),
              vertical: _appConfig.verticalSpace(),
            ),
            child: ListView(
              children: <Widget>[
                ProfilePicture(),
                SizedBox(height: _appConfig.smallSpace()),
                Text(
                  currentUser.value.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: _appConfig.extraSmallSpace()),
                Text(
                  currentUser.value.email,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Divider(),
                ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: _appConfig.appHeight(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconTextButton(
                        width: _appConfig.appWidth(40),
                        icon: AppIcons.direction,
                        text: LocaleKeys.title_my_address.tr(),
                        onPressed: _controller.myAddress,
                      ),
                      VerticalDivider(),
                      IconTextButton(
                        width: _appConfig.appWidth(40),
                        icon: AppIcons.location,
                        text: LocaleKeys.title_edit_profile.tr(),
                        onPressed: _controller.editProfile,
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: _controller.wishList,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: _appConfig.horizontalSpace(),
                  ),
                  leading: Icon(AppIcons.heart_empty_1),
                  title: Text(
                    LocaleKeys.title_wishlist.tr(),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: _controller.myOrders,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: _appConfig.horizontalSpace(),
                  ),
                  leading: Icon(AppIcons.ic_cart),
                  title: Text(
                    LocaleKeys.menu_my_orders.tr(),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    _controller.userLogout();
                  },
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: _appConfig.horizontalSpace(),
                  ),
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    LocaleKeys.menu_logout.tr(),
                  ),
                ),
                Divider(),
              ],
            ),
          );
  }
}
