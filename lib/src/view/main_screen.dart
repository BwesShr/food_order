import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/cart/navbar_cart_icon.dart';
import 'package:food_order/src/widget/connectivity_check.dart';
import 'package:food_order/src/widget/drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'main/cart_screen.dart';
import 'main/history_screen.dart';
import 'main/home_screen.dart';
import 'main/profile_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
    @required this.currentTab = 0,
  });

  int currentTab;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends StateMVC<MainScreen> {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _saveData = SaveData();
  Locale locale;

  HomeController _controller;
  _MainScreenState() : super(HomeController()) {
    _controller = controller;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    _fetchLocale();
    _controller.listenForCartCount();
    _controller.listenForPromoSlider();
    _controller.listenForFoodCategory();
    _controller.listenForTrendingFoods();

    super.initState();
  }

  _fetchLocale() async {
    _saveData.getString(_saveData.LANGUAGE_CODE).then((value) {
      if (value == null) value = 'en';
      setState(() {
        locale = Locale(value, '');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          appBar: HomeAppbar(
            title: _setCurrentPaggeTitle(widget.currentTab),
            openDrawer: () => _scaffoldKey.currentState.openDrawer(),
          ),
          body: ConnectivityCheck(
            child: _selectCurrentPage(widget.currentTab),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: widget.currentTab,
            height: _appConfig.appHeight(7),
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).buttonColor,
            buttonBackgroundColor: secondaryColor,
            onTap: (position) => setState(() {
              widget.currentTab = position;
            }),
            items: navBarItems(context),
          ),
        ),
      ),
    );
  }

  String _setCurrentPaggeTitle(int tabItem) {
    switch (tabItem) {
      case 0:
        return LocaleKeys.tab_home.tr();
      case 1:
        return LocaleKeys.tab_cart.tr();
      case 2:
        return LocaleKeys.tab_history.tr();
      case 3:
        return LocaleKeys.tab_profile.tr();
      default:
        return LocaleKeys.tab_home.tr();
    }
  }

  Widget _selectCurrentPage(int tabItem) {
    switch (tabItem) {
      case 0:
        return HomeScreen(
          parentScaffoldKey: _scaffoldKey,
          controller: _controller,
        );
      case 1:
        return CartScreen(
          parentScaffoldKey: _scaffoldKey,
          onContinuShoppingPressed: () {
            setState(() {
              widget.currentTab = 0;
            });
          },
        );
      case 2:
        return HistoryScreen(
          parentScaffoldKey: _scaffoldKey,
        );
      case 3:
        return ProfileScreen(
          parentScaffoldKey: _scaffoldKey,
        );
      default:
        return HomeScreen(
          parentScaffoldKey: _scaffoldKey,
          controller: _controller,
        );
    }
  }

  List<Widget> navBarItems(BuildContext context) {
    return <Widget>[
      buildIcon(context, AppIcons.ic_home, 0),
      NavBarCartIcon(
        currentTab: widget.currentTab,
        cartCount: _controller.cartCount,
      ),
      buildIcon(context, AppIcons.ic_history, 2),
      buildIcon(context, AppIcons.ic_profile, 3),
    ];
  }

  Icon buildIcon(BuildContext context, IconData icon, int index) {
    final _appConfig = config.AppConfig(context);
    return Icon(
      icon,
      color: widget.currentTab == index
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      size: _appConfig.navBarIconSize(),
    );
  }
}
