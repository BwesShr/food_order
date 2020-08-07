import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:food_order/src/utils/color_theme.dart';

class ConnectivityCheck extends StatelessWidget {
  ConnectivityCheck({
    Key key,
    this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: connected
                  ? Container()
                  : Container(
                      height: 50.0,
                      color: Theme.of(context).buttonColor,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.wifi,
                              color: whiteColor,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'No Internet Connection',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
      child: child,
    );
  }
}
