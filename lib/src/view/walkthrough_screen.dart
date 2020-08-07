import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/walkthrough_controller.dart';
import 'package:food_order/src/model/walkthrough.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:food_order/src/widget/buttons/primary_button.dart';
import 'package:food_order/src/widget/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:food_order/src/widget/walkthrough/walkthrough_even_item_widget.dart';
import 'package:food_order/src/widget/walkthrough/walkthrough_odd_item_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WalkthroughScreen extends StatefulWidget {
  WalkthroughScreen({
    Key key,
  }) : super(key: key);

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends StateMVC<WalkthroughScreen> {
  WalkthroughController _con;

  _WalkthroughScreenState() : super(WalkthroughController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();

    _con.listenForWalkThrough();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(''),
      ),
      body: Container(
        height: _appConfig.appHeight(100),
        child: Column(
          children: [
            Expanded(
              child: _con.walkthroughs.isEmpty
                  ? Offstage()
                  : Swiper(
                      itemCount: _con.walkthroughs.length,
                      onIndexChanged: (index) {
                        setState(() {
                          _con.updatePageIndex(index);
                        });
                      },
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Theme.of(context).hintColor,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        ),
                      ),
                      itemBuilder: (context, index) {
                        Walkthrough walkthrough = _con.walkthroughs[index];
                        return index % 2 == 0
                            ? WalkthroughEvenItemWidget(
                                walkthrough: walkthrough,
                              )
                            : WalkthroughOddItemWidget(
                                walkthrough: walkthrough);
                      },
                    ),
            ),
            SizedBox(height: _appConfig.smallSpace()),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _appConfig.horizontalSpace(),
              ),
              child: PrimaryButton(
                text: LocaleKeys.action_next.tr(),
                onPressed: _con.finishWalkthrough,
              ),
            ),
            SizedBox(height: _appConfig.smallSpace()),
            Opacity(
              opacity: _con.pageIndex + 1 < _con.walkthroughs.length ? 1 : 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _appConfig.horizontalSpace(),
                ),
                child: SecondaryButton(
                  text: LocaleKeys.action_skip.tr(),
                  onPressed: () {
                    if (_con.pageIndex + 1 < _con.walkthroughs.length) {
                      _con.finishWalkthrough();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
