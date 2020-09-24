import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/constants.dart';

class ItemQuantityWidget extends StatelessWidget {
  ItemQuantityWidget({
    Key key,
    @required this.quantity,
    @required this.onDecreaseQuantity,
    @required this.onIncreaseQuantity,
  }) : super(key: key);

  final int quantity;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onIncreaseQuantity;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: onDecreaseQuantity,
          child: ClipOval(
            child: Material(
              color: AppColors.secondaryColor,
              child: SizedBox(
                width: 25,
                height: 25,
                child: Icon(
                  Icons.remove,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: _appConfig.horizontalSpace()),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 18.0),
        ),
        SizedBox(width: _appConfig.horizontalSpace()),
        InkWell(
          onTap: onIncreaseQuantity,
          child: ClipOval(
            child: Material(
              color: AppColors.secondaryColor,
              child: SizedBox(
                width: 25,
                height: 25,
                child: Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
