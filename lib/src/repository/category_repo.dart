import 'dart:async';
import 'dart:convert';

import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:http/http.dart' as http;

Future<Stream<Category>> getFoodCategories() async {
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

  String foodByCategoryUrl =
      food_by_category_url.replaceAll('{categoryid}', '$id');
  final streamedRest =
      await client.send(http.Request('get', Uri.parse(foodByCategoryUrl)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => _functions.getData(data))
      .expand((data) => (data as List))
      .map((data) => Food.fromJSON(data));
}

getCategories() {
  return [
    new Category(
      id: 1,
      slug: 'grains',
      name: 'Grains',
      image:
          'https://multi-restaurants.smartersvision.com/storage/app/public/133/milk.svg',
    ),
    new Category(
      id: 2,
      slug: 'sandwiches',
      name: "Sandwiches",
      image:
          'https://multi-restaurants.smartersvision.com/storage/app/public/131/hamburguer-1.svg',
    ),
    new Category(
      id: 3,
      slug: 'vegetables',
      name: 'Vegetables',
      image:
          'https://multi-restaurants.smartersvision.com/storage/app/public/139/food.svg',
    ),
    new Category(
      id: 4,
      slug: 'fruits',
      name: 'Fruits',
      image:
          'https://multi-restaurants.smartersvision.com/storage/app/public/135/raspberry.svg',
    ),
    new Category(
      id: 5,
      slug: 'protein',
      name: 'Protein',
      image:
          'https://multi-restaurants.smartersvision.com/storage/app/public/137/cupcake-1.svg',
    ),
  ];
}
