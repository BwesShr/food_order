import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  Appbar({
    Key key,
    this.title,
  });
  final String title;
  final double height = 60.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).buttonColor, //change your color here
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).buttonColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
