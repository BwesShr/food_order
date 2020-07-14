import 'dart:async';
import 'dart:convert';

import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:http/http.dart' as http;

Future<Stream<Category>> getProductCategories() async {
  final _functions = Functions();
  final client = new http.Client();

  final streamedRest =
      await client.send(http.Request('get', Uri.parse(food_category_url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => _functions.getData(data))
      .expand((data) => (data as List))
      .map((data) => Category.fromJSON(data));
}

Future<Stream<Food>> getProductsByCategory(int id) async {
  final _functions = Functions();
  final client = new http.Client();

  final streamedRest =
      await client.send(http.Request('get', Uri.parse(food_category_url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => _functions.getData(data))
      .expand((data) => (data as List))
      .map((data) => Food.fromJSON(data));
}
