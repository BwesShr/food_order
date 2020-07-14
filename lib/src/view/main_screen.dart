import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/utils/local_strings.dart';
import 'package:food_order/src/utils/save_data.dart';
import 'package:food_order/src/widget/connectivity_check.dart';
import 'package:food_order/src/widget/drawer_widget.dart';
import 'package:flutter/material.dart';

import 'home/cart_screen.dart';
import 'home/history_screen.dart';
import 'home/home_screen.dart';
import 'home/profile_screen.dart';
import 'home/search_screen.dart';

class MainScreen extends StatefulWidget {
  int currentTab;

  MainScreen({Key key, this.currentTab}) {
    currentTab = currentTab != null ? currentTab : 0;
  }

  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _currentPage = HomeScreen();
  final _saveData = SaveData();
  Locale locale;
  String _title;

  @override
  void initState() {
    super.initState();
    _currentPage = HomeScreen();
    _selectTab(widget.currentTab);
    _fetchLocale();
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
  void didUpdateWidget(MainScreen oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          _title = tab_home;
          _currentPage = HomeScreen(parentScaffoldKey: scaffoldKey);
          break;
        case 1:
          _title = tab_search;
          _currentPage = SearchScreen(parentScaffoldKey: scaffoldKey);
          break;
        case 2:
          _title = tab_cart;
          _currentPage = CartScreen(parentScaffoldKey: scaffoldKey);
          break;
        case 3:
          _title = tab_history;
          _currentPage = HistoryScreen(parentScaffoldKey: scaffoldKey);
          break;
        case 4:
          _title = tab_profile;
          _currentPage = ProfileScreen(parentScaffoldKey: scaffoldKey);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: DrawerWidget(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.sort, color: Theme.of(context).buttonColor),
                onPressed: () => scaffoldKey.currentState.openDrawer(),
              ),
              title: Text(
                _title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).buttonColor),
              ),
            ),
            body: ConnectivityCheck(child: _currentPage),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              color: Theme.of(context).accentColor,
              buttonBackgroundColor: Theme.of(context).accentColor,
              backgroundColor: Theme.of(context).primaryColor,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 400),
              items: <Widget>[
                Icon(
                  AppIcons.ic_home,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  AppIcons.ic_search,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  AppIcons.ic_cart,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                Icon(
                  AppIcons.ic_history,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  AppIcons.ic_profile,
                  color: Theme.of(context).primaryColor,
                ),
              ],
              onTap: (position) {
                setState(() {
                  this._selectTab(position);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
