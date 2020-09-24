import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'main/cart_screen.dart';
import 'main/home_screen.dart';
import 'main/messages_screen.dart';
import 'main/profile_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
    @required this.currentTab,
  }) : super(key: key);

  int currentTab;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends StateMVC<MainScreen> {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeController _controller;
  final _saveData = SaveData();
  final _functions = Functions();
  Locale locale;

  _MainScreenState() : super(HomeController()) {
    _controller = controller;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.initState();
  }

  // _fetchLocale() async {
  //   _saveData.getString(_saveData.LANGUAGE_CODE).then((value) {
  //     if (value == null) value = 'en';
  //     setState(() {
  //       locale = Locale(value, '');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerWidget(
              scaffoldKey: _scaffoldKey,
            ),
            appBar: HomeAppbar(
              title: _setCurrentPageTitle(widget.currentTab),
              openDrawer: () => _scaffoldKey.currentState.openDrawer(),
            ),
            body: ConnectivityCheck(
              child: IndexedStack(
                index: widget.currentTab,
                children: _setCurrentPage(),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: widget.currentTab,
              key: _bottomNavigationKey,
              height: _appConfig.appHeight(8),
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).buttonColor,
              buttonBackgroundColor: AppColors.secondaryColor,
              items: navBarItems(context),
              onTap: (position) => setState(() {
                widget.currentTab = position;
              }),
            ),
          ),
        ),
      ),
    );
  }

  String _setCurrentPageTitle(int tabItem) {
    switch (tabItem) {
      case 0:
        return LocaleKeys.tab_home.tr();
      case 1:
        return LocaleKeys.tab_cart.tr();
      case 2:
        return LocaleKeys.tab_message.tr();
      case 3:
        return LocaleKeys.tab_profile.tr();
      default:
        return LocaleKeys.tab_home.tr();
    }
  }

  List<Widget> _setCurrentPage() {
    return [
      HomeScreen(
        parentScaffoldKey: _scaffoldKey,
        controller: _controller,
      ),
      CartScreen(
        parentScaffoldKey: _scaffoldKey,
        onContinuShoppingPressed: () {
          setState(() {
            widget.currentTab = 0;
          });
        },
      ),
      NotificationScreen(
        parentScaffoldKey: _scaffoldKey,
      ),
      ProfileScreen(
        parentScaffoldKey: _scaffoldKey,
      ),
      HomeScreen(
        parentScaffoldKey: _scaffoldKey,
        controller: _controller,
      ),
    ];
  }

  List<Widget> navBarItems(BuildContext context) {
    return <Widget>[
      buildIcon(context, AppIcons.ic_home, 0),
      NavBarCartIcon(
        currentTab: widget.currentTab,
        cartCount: userCartCount.value,
      ),
      buildIcon(context, AppIcons.comment, 2),
      buildIcon(context, AppIcons.ic_profile, 3),
    ];
  }

  Icon buildIcon(BuildContext context, IconData icon, int index) {
    final _appConfig = config.AppConfig(context);
    return Icon(
      icon,
      color: widget.currentTab == index
          ? AppColors.whiteColor
          : Theme.of(context).hintColor,
      size: _appConfig.navBarIconSize(),
    );
  }
}
