import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/model/review.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/functions.dart';
import 'package:simple_html_css/simple_html_css.dart';

class ReviewsListWidget extends StatelessWidget {
  ReviewsListWidget({
    Key key,
    @required this.reviewsList,
    @required this.onReviewPressed,
  }) : super(key: key);

  final List<Review> reviewsList;
  final ValueChanged<Review> onReviewPressed;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return reviewsList.isEmpty
        ? CircularProgressIndicator()
        : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            itemCount: reviewsList.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemBuilder: (context, index) {
              Review review = reviewsList.elementAt(index);
              return InkWell(
                onTap: () => onReviewPressed(review),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${review.user.name}',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: _appConfig.extraSmallSpace()),
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: HTML.toTextSpan(
                        context,
                        review.review,
                        defaultTextStyle: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
