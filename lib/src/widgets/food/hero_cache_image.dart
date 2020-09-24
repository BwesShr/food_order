import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

import '../image_placeholder.dart';

class HeroCacheImage extends StatelessWidget {
  const HeroCacheImage({
    Key key,
    @required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return CachedNetworkImage(
      imageUrl: image,
      width: double.infinity,
      placeholder: (context, url) => ImagePlaceHolder(),
      errorWidget: (context, url, error) => ImagePlaceHolder(),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_appConfig.borderRadius()),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(_appConfig.borderRadius()),
          ),
        ),
      ),
    );
  }
}
