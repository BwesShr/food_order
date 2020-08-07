import 'dart:convert';
import 'dart:io';

import 'package:food_order/src/model/cart.dart';
import 'package:food_order/src/model/extra.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/model/ingrident.dart';
import 'package:food_order/src/model/media.dart';
import 'package:food_order/src/model/review.dart';
import 'package:food_order/src/model/user.dart';
import 'package:food_order/src/utils/api_config.dart';
import 'package:food_order/src/utils/functions.dart';
import 'package:http/http.dart' as http;

import 'user_repo.dart' as userRepo;

Future<Stream<Cart>> getCart() async {
  final _functions = Functions();
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String url = user_cart_url(_user.apiToken, _user.id);

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => _functions.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Cart.fromJSON(data);
  });
}

Future<Stream<int>> getCartCount() async {
  final _functions = Functions();
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(0);
  }
  final String url = user_cart_count_url(_user.apiToken, _user.id);

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map(
        (data) => _functions.getIntData(data),
      );
}

Future<Cart> addCart(Cart cart, bool reset) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Cart.empty();
  }
  Map<String, dynamic> decodedJSON = {};
  final String resetParam = 'reset=${reset ? 1 : 0}';
  cart.userId = _user.id;
  final String url = user_add_cart_url(_user.apiToken, resetParam);
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(cart.toMap()),
  );
  try {
    decodedJSON = json.decode(response.body)['data'] as Map<String, dynamic>;
  } on FormatException catch (e) {
    print("The provided string is not valid JSON addCart");
  }
  return Cart.fromJSON(decodedJSON);
}

Future<Cart> updateCart(Cart cart) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Cart.empty();
  }
  cart.userId = _user.id;
  final String url = user_update_cart_url(cart.id, _user.apiToken);
  final client = new http.Client();
  final response = await client.put(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(cart.toMap()),
  );
  return Cart.fromJSON(json.decode(response.body)['data']);
}

Future<bool> removeCart(Cart cart) async {
  final _functions = Functions();
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = user_remove_cart_url(cart.id, _user.apiToken);
  final client = new http.Client();
  final response = await client.delete(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  return _functions.getBoolData(json.decode(response.body));
}

List<Cart> getFoodCart() {
  return [
    new Cart(
      id: 1,
      userId: 1,
      quantity: 2,
      selected: false,
      ingridents: [
        new Ingrident(
          id: 1,
          name: 'Tomato sauce',
          price: 50,
        ),
        new Ingrident(
          id: 2,
          name: 'Mozzarella',
          price: 50,
        ),
      ],
      extras: [
        new Extra(
          id: 3,
          name: 'Mushrooms',
          price: 50,
        ),
      ],
      food: new Food(
        id: 3,
        categoryId: 1,
        name: 'Pizza Valtellina',
        price: 130,
        discount: 0,
        image: new Media(
          id: 1,
          url:
              'https://multi-restaurants.smartersvision.com/storage/app/public/101/pizza-2802332_1280.jpg',
          thumb:
              'https://multi-restaurants.smartersvision.com/storage/app/public/101/conversions/pizza-2802332_1280-thumb.jpg',
          icon:
              'https://multi-restaurants.smartersvision.com/storage/app/public/101/conversions/pizza-2802332_1280-icon.jpg',
        ),
        excerpt:
            '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
        description:
            '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
        weight: '245.3',
        featured: false,
        rating: 2.5,
        ingridents: [
          new Ingrident(
            id: 1,
            name: 'Tomato sauce',
            price: 50,
          ),
          new Ingrident(
            id: 2,
            name: 'Mozzarella',
            price: 50,
          ),
          new Ingrident(
            id: 3,
            name: 'Mushrooms',
            price: 50,
          ),
          new Ingrident(
            id: 4,
            name: 'Pepperoni',
            price: 50,
          ),
          new Ingrident(
            id: 5,
            name: 'Stracchino',
            price: 50,
          ),
        ],
        extras: [
          new Extra(
            id: 1,
            name: 'Tomato sauce',
            price: 50,
          ),
          new Extra(
            id: 2,
            name: 'Mozzarella',
            price: 50,
          ),
          new Extra(
            id: 3,
            name: 'Mushrooms',
            price: 50,
          ),
          new Extra(
            id: 4,
            name: 'Pepperoni',
            price: 50,
          ),
          new Extra(
            id: 5,
            name: 'Stracchino',
            price: 50,
          ),
        ],
        foodReviews: [
          new Review(
            id: 1,
            review:
                '<p>Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br></p>',
            rate: 4,
            user: new User(
              id: 1,
              fname: 'Barbara',
              lname: 'Glanz',
              email: 'manager@demo.com',
              phone: '+136 226 5669',
              address: '2911 Corpening Drive South Lyon, MI 48178',
              image: new Media(
                id: 67,
                url:
                    'https://multi-restaurants.smartersvision.com/storage/app/public/67/user1.jpg',
                thumb:
                    'https://multi-restaurants.smartersvision.com/storage/app/public/67/conversions/user1-thumb.jpg',
                icon:
                    'https://multi-restaurants.smartersvision.com/storage/app/public/67/conversions/user1-icon.jpg',
              ),
            ),
          ),
        ],
      ),
    ),
    new Cart(
      id: 1,
      userId: 1,
      quantity: 1,
      selected: false,
      ingridents: [
        new Ingrident(
          id: 1,
          name: 'Tomato sauce',
          price: 50,
        ),
        new Ingrident(
          id: 2,
          name: 'Mozzarella',
          price: 50,
        ),
      ],
      extras: [
        new Extra(
          id: 1,
          name: 'Tomato sauce',
          price: 50,
        ),
        new Extra(
          id: 2,
          name: 'Mozzarella',
          price: 50,
        ),
        new Extra(
          id: 3,
          name: 'Mushrooms',
          price: 50,
        ),
      ],
      food: new Food(
        id: 6,
        categoryId: 3,
        name: 'Chicken Noodle Soup',
        price: 90,
        discount: 0,
        image: new Media(
          id: 1,
          url:
              'https://multi-restaurants.smartersvision.com/storage/app/public/113/soup-4115245_1280.jpg',
          thumb:
              'https://multi-restaurants.smartersvision.com/storage/app/public/113/conversions/soup-4115245_1280-thumb.jpg',
          icon:
              'https://multi-restaurants.smartersvision.com/storage/app/public/113/conversions/soup-4115245_1280-icon.jpg',
        ),
        excerpt:
            '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
        description:
            '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
        weight: '190',
        featured: false,
        rating: 3.0,
        ingridents: [
          new Ingrident(
            id: 1,
            name: 'Tomato sauce',
            price: 50,
          ),
          new Ingrident(
            id: 2,
            name: 'Mozzarella',
            price: 50,
          ),
          new Ingrident(
            id: 3,
            name: 'Mushrooms',
            price: 50,
          ),
          new Ingrident(
            id: 4,
            name: 'Pepperoni',
            price: 50,
          ),
          new Ingrident(
            id: 5,
            name: 'Stracchino',
            price: 50,
          ),
        ],
        extras: [
          new Extra(
            id: 1,
            name: 'Tomato sauce',
            price: 50,
          ),
          new Extra(
            id: 2,
            name: 'Mozzarella',
            price: 50,
          ),
          new Extra(
            id: 3,
            name: 'Mushrooms',
            price: 50,
          ),
          new Extra(
            id: 4,
            name: 'Pepperoni',
            price: 50,
          ),
          new Extra(
            id: 5,
            name: 'Stracchino',
            price: 50,
          ),
        ],
        foodReviews: [
          new Review(
            id: 1,
            review:
                '<p>Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br></p>',
            rate: 4,
            user: new User(
              id: 1,
              fname: 'Barbara',
              lname: 'Glanz',
              email: 'manager@demo.com',
              phone: '+136 226 5669',
              address: '2911 Corpening Drive South Lyon, MI 48178',
              image: new Media(
                id: 67,
                url:
                    'https://multi-restaurants.smartersvision.com/storage/app/public/67/user1.jpg',
                thumb:
                    'https://multi-restaurants.smartersvision.com/storage/app/public/67/conversions/user1-thumb.jpg',
                icon:
                    'https://multi-restaurants.smartersvision.com/storage/app/public/67/conversions/user1-icon.jpg',
              ),
            ),
          ),
        ],
      ),
    ),
  ];
}
