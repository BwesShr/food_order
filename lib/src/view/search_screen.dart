import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:food_order/presentation/app_icons_icons.dart';
import 'package:food_order/src/controller/search_controller.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/route_generator.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:food_order/src/widget/appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/widget/image_placeholder.dart';
import 'package:food_order/src/widget/progress_dialog.dart';
import 'package:food_order/src/widget/search_filter_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends StateMVC<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  final _functions = Functions();
  SearchController _controller;
  String searckKeyWord;

  _SearchScreenState() : super(SearchController()) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          key: _controller.scaffoldKey,
          appBar: Appbar(
            title: LocaleKeys.title_search.tr(),
          ),
          endDrawer: FilterDrawerWidget(
            controller: _controller,
            categories:
                _functions.stringToList(LocaleKeys.filter_categories.tr()),
            types: _functions.stringToList(LocaleKeys.filter_types.tr()),
            onApplyPressed: () =>
                _controller.listenForSearch(_searchController.text),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalSpace(),
              vertical: _appConfig.verticalSpace(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SearchTextForm(
                        searchController: _searchController,
                        searchFocus: _searchFocus,
                        onSubmitData: _controller.listenForSearch,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          _controller.scaffoldKey.currentState.openEndDrawer(),
                      child: Container(
                        padding: EdgeInsets.all(_appConfig.extraSmallSpace()),
                        child: Icon(
                          AppIcons.filter,
                          size: _appConfig.filterIconSize(),
                        ),
                      ),
                    ),
                  ],
                ),
                _controller.isLoading
                    ? ProgressDialog()
                    : _controller.foods.length == 0
                        ? Container()
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(
                              vertical: _appConfig.verticalSpace(),
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: _controller.foods.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                  height: _appConfig.extraSmallSpace());
                            },
                            itemBuilder: (context, index) {
                              Food food = _controller.foods[index];
                              return InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                    foodRoute,
                                    arguments: {arg_food_id: food.id}),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: _appConfig.verticalSpace(),
                                      horizontal: _appConfig.horizontalSpace()),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      _appConfig.containerShadow(),
                                    ],
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: CachedNetworkImage(
                                          height: _appConfig.appWidth(25),
                                          width: _appConfig.appWidth(25),
                                          fit: BoxFit.cover,
                                          imageUrl: food.image.thumb,
                                          placeholder: (context, url) =>
                                              ImagePlaceHolder(),
                                          errorWidget: (context, url, error) =>
                                              ImagePlaceHolder(),
                                        ),
                                      ),
                                      SizedBox(width: _appConfig.smallSpace()),
                                      Flexible(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    food.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        LocaleKeys.amount_unit
                                                            .tr(namedArgs: {
                                                          'amount':
                                                              '${(food.discount != 0) ? _functions.getDiscountedPrice(food) : food.price}'
                                                        }),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2
                                                            .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .buttonColor,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTextForm extends StatelessWidget {
  SearchTextForm({
    Key key,
    @required this.searchController,
    @required this.searchFocus,
    @required this.onSubmitData,
  }) : super(key: key);

  final TextEditingController searchController;
  final FocusNode searchFocus;
  final ValueChanged<String> onSubmitData;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return TextFormField(
      controller: searchController,
      focusNode: searchFocus,
      style: Theme.of(context).textTheme.caption,
      cursorColor: Theme.of(context).accentColor,
      onFieldSubmitted: onSubmitData,
      decoration: InputDecoration(
        filled: true,
        fillColor: lightGreyColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: _appConfig.horizontalSpace(),
          vertical: _appConfig.verticalSpace(),
        ),
        hintText: LocaleKeys.hint_search_foods.tr(),
        hintStyle:
            Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            onSubmitData(searchController.text);
          },
          child: Icon(
            AppIcons.ic_search,
            size: _appConfig.searchIconSize(),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
