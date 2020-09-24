import 'dart:convert';

import 'package:food_order/src/repository/static_data.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:http/http.dart';

import '../models/model.dart';

final _functions = Functions();

Future<List<HomePromo>> getPromoSlider() async {
  // final _functions = Functions();
  // final client = new http.Client();

  // final streamedRest =
  //     await client.send(http.Request('get', Uri.parse(home_promo_url)));

  // return streamedRest.stream
  //     .transform(utf8.decoder)
  //     .transform(json.decoder)
  //     .map((data) => _functions.getData(data))
  //     .expand((data) => (data as List))
  //     .map((data) => HomePromo.fromJSON(data));

  await Future.delayed(Duration(seconds: 3));
  Response response = Response(homePromoData, 200);

  var result = json.decode(response.body);
  return (result['data'] as List)
      .map((data) => HomePromo.fromJSON(data))
      .toList();
}
