import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
