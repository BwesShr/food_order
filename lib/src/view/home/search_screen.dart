import 'package:food_order/src/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
