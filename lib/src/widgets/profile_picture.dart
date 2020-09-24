import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

class ProfilePicture extends StatefulWidget {
  ProfilePicture({Key key}) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return (currentUser.value.image == null) || (currentUser.value.image == '')
        ? CircleAvatar(
            radius: _appConfig.appWidth(21),
            backgroundColor: Theme.of(context).buttonColor,
            child: CircleAvatar(
              radius: _appConfig.appWidth(20),
              backgroundImage: AssetImage(AppImages.appIcon),
            ),
          )
        : CircleAvatar(
            radius: _appConfig.appWidth(21),
            backgroundColor: Theme.of(context).buttonColor,
            child: CircleAvatar(
              radius: _appConfig.appWidth(20),
              backgroundImage: NetworkImage(currentUser.value.image),
            ),
          );
  }
}
