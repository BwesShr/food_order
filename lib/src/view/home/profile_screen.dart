import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
