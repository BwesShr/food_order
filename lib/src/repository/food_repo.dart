import 'dart:convert';
import 'dart:async';

import 'package:food_order/src/repository/static_data.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:http/http.dart';

import '../models/model.dart';

final _functions = Functions();

Future<List<Category>> getFoodCategories() async {
  await Future.delayed(Duration(seconds: 3));
  Response response = Response(foodCategoryData, 200);

  var result = json.decode(response.body);
  return (result['data'] as List)
      .map((data) => Category.fromJSON(data))
      .toList();
}

Future<List<Food>> getTrendingFoods() async {
  await Future.delayed(Duration(seconds: 3));
  Response response = Response(trendindFoodData, 200);

  var result = json.decode(response.body);
  return (result['data'] as List).map((data) => Food.fromJSON(data)).toList();
}

Future<List<Food>> getFoodsByCategory(int id) async {
  await Future.delayed(Duration(seconds: 3));
  Response response = Response(foodByCategoryData, 200);

  var result = json.decode(response.body);
  return (result['data'] as List).map((data) => Food.fromJSON(data)).toList();
}

Future<List<Food>> getSearchFoods({Map body}) async {
  await Future.delayed(Duration(seconds: 3));
  Response response = Response(foodByCategoryData, 200);

  var result = json.decode(response.body);
  return (result['data'] as List).map((data) => Food.fromJSON(data)).toList();
}

Future<Food> getFoodById(int id) async {
  await Future.delayed(Duration(seconds: 3));
  Response response = Response(foodByIdData, 200);
  print('result: ${response.body}');
  var result = json.decode(response.body);
  print('json: ${result['data']}');
  return Food.fromJSON(result['data']);
}

Future<Stream<Cart>> getCartById(int id) async {
  final _functions = Functions();
  final client = new Client();
  final streamedRest =
      await client.send(Request('get', Uri.parse(cart_by_details_url(id))));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => _functions.getData(data))
      .map((data) {
    return Cart.fromJSON(data);
  });
}
