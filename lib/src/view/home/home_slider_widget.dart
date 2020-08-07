import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/controller/home_controller.dart';
import 'package:food_order/src/model/home_slider.dart';
import 'package:food_order/src/utils/images.dart';
import 'package:food_order/src/widget/image_placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSliderWidget extends StatelessWidget {
  HomeSliderWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.sliders.length > 0 ? true : false,
      child: CarouselSlider(
        options: CarouselOptions(
          initialPage: 0,
          autoPlay: true,
          aspectRatio: 2.2,
          enlargeCenterPage: true,
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayOnManualNavigate: true,
          autoPlayCurve: Curves.easeInOutCubic,
          autoPlayInterval: Duration(seconds: 10),
          autoPlayAnimationDuration: Duration(seconds: 1),
        ),
        items: controller.sliders
            .map(
              (slider) => SliderItemWidget(slider: slider),
            )
            .toList(),
      ),
    );
  }
}

class SliderItemWidget extends StatelessWidget {
  SliderItemWidget({
    Key key,
    this.slider,
  }) : super(key: key);
  final HomeSlider slider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (slider.url != null) {
          launch(slider.url);
        }
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: slider.image,
                width: double.infinity,
                placeholder: (context, url) => ImagePlaceHolder(),
                errorWidget: (context, url, error) => ImagePlaceHolder(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
