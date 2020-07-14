import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';
import 'package:food_order/src/utils/local_strings.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({
    Key key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  int _searchLength = 0;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalPadding(5),
        vertical: _appConfig.verticalPadding(2),
      ),
      child: TextFormField(
        controller: _searchController,
        focusNode: _searchFocus,
        style: Theme.of(context).textTheme.caption,
        cursorColor: Theme.of(context).accentColor,
        onChanged: (value) {
          if (value.isNotEmpty)
            print('length: $value');
          else
            print('length: empty');
          setState(() {
            _searchLength = value.length;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: lightGreyBackgroundColor,
          contentPadding:
              EdgeInsets.symmetric(horizontal: _appConfig.horizontalPadding(5)),
          hintText: search_products,
          hintStyle: Theme.of(context)
              .textTheme
              .caption
              .merge(TextStyle(fontSize: 14)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(
                right: _appConfig.horizontalPadding(2), left: 0),
            child: Icon(Icons.search, color: Theme.of(context).accentColor),
          ),
          suffixIcon: _searchLength > 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchLength = 0;
                      _searchController.clear();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subTextColor,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 15.0,
                      color: hintColor,
                    ),
                  ),
                )
              : Offstage(),
        ),
        onFieldSubmitted: searchData,
      ),
    );
    // return InkWell(
    //   onTap: () {
    //     // Navigator.of(context).push(SearchModal());
    //   },
    //   child: Container(
    //     padding: EdgeInsets.all(12),
    //     decoration: BoxDecoration(
    //         color: Theme.of(context).hintColor,

    //         border: Border.all(
    //           color: Theme.of(context).focusColor.withOpacity(0.2),
    //         ),
    //         borderRadius: BorderRadius.circular(4)),
    //     child: Row(
    //       children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.only(right: 12, left: 0),
    //           child: Icon(Icons.search, color: Theme.of(context).accentColor),
    //         ),
    //         Text(
    //           'search_for_restaurants_or_foods',
    //           style: Theme.of(context)
    //               .textTheme
    //               .caption
    //               .merge(TextStyle(fontSize: 14)),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  void searchData(String value) {}
}
