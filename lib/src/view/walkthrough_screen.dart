import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/src/controller/walkthrough_controller.dart';
import 'package:food_order/src/models/model.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/widgets/widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WalkthroughScreen extends StatefulWidget {
  WalkthroughScreen({
    Key key,
  }) : super(key: key);

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends StateMVC<WalkthroughScreen> {
  WalkthroughController _controller;

  _WalkthroughScreenState() : super(WalkthroughController()) {
    _controller = controller;
  }

  @override
  void initState() {
    super.initState();

    _controller.listenForWalkThrough();
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: null,
      ),
      body: Column(
        children: [
          Expanded(
            child: _controller.walkthroughs.isEmpty
                ? Offstage()
                : Swiper(
                    loop: false,
                    autoplayDisableOnInteraction: true,
                    itemCount: _controller.walkthroughs.length,
                    onIndexChanged: _controller.updateIndex,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Theme.of(context).hintColor,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      Walkthrough walkthrough = _controller.walkthroughs[index];
                      return index % 2 == 0
                          ? WalkthroughEvenItemWidget(
                              walkthrough: walkthrough,
                            )
                          : WalkthroughOddItemWidget(
                              walkthrough: walkthrough,
                            );
                    },
                  ),
          ),
          SizedBox(height: _appConfig.smallSpace()),
          PrimaryButton(
            width: _appConfig.appWidth(80),
            text: LocaleKeys.action_next.tr(),
            onPressed: _controller.finishWalkthrough,
          ),
          SizedBox(height: _appConfig.smallSpace()),
          Opacity(
            opacity: _controller.checkIndex() ? 1 : 0,
            child: SecondaryButton(
              width: _appConfig.appWidth(80),
              text: LocaleKeys.action_skip.tr(),
              onPressed: () => _controller.checkIndex()
                  ? _controller.finishWalkthrough()
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
