import 'dart:convert';

import 'package:food_order/src/model/category.dart';
import 'package:food_order/src/model/extra.dart';
import 'package:food_order/src/model/food.dart';
import 'package:food_order/src/model/ingrident.dart';
import 'package:food_order/src/model/media.dart';
import 'package:food_order/src/model/review.dart';
import 'package:food_order/src/model/user.dart';
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

Future<Stream<Food>> getTrendingFoods() async {
  final _functions = Functions();
  final client = new http.Client();

  final streamedRest =
      await client.send(http.Request('get', Uri.parse(popular_food_url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => _functions.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Food.fromJSON(data);
  });
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

List<Food> getFoods() {
  return [
    new Food(
      id: 1,
      categoryId: 1,
      name: 'Pizza Margherita',
      price: 160,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '200',
      featured: true,
      rating: 3.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/96/margherita-pizza-993274_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/96/conversions/margherita-pizza-993274_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/96/conversions/margherita-pizza-993274_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
        new Review(
          id: 1,
          review:
              '<p>Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br></p>',
          rate: 4,
          user: new User(
            id: 1,
            name: 'Barbara Glanz',
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
        new Review(
          id: 1,
          review:
              '<p>Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<br></p>',
          rate: 4,
          user: new User(
            id: 1,
            name: 'Barbara Glanz',
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
    new Food(
      id: 2,
      categoryId: 1,
      name: 'Pizza Montanara',
      price: 150,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '290.5',
      featured: false,
      rating: 3.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/99/pizza-2000615_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/99/conversions/pizza-2000615_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/99/conversions/pizza-2000615_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 3,
      categoryId: 1,
      name: 'Pizza Valtellina',
      price: 130,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '245.3',
      featured: false,
      rating: 2.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/101/pizza-2802332_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/101/conversions/pizza-2802332_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/101/conversions/pizza-2802332_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 4,
      categoryId: 1,
      name: 'Pizza al Pesto',
      price: 135,
      discount: 10,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '240',
      featured: false,
      rating: 3.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/103/pizza-1081543_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/103/conversions/pizza-1081543_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/103/conversions/pizza-1081543_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 5,
      categoryId: 1,
      name: 'Pasta Pappardelle',
      price: 120,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '290',
      featured: false,
      rating: 4.0,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/109/spaghetti-3547078_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/109/conversions/spaghetti-3547078_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/109/conversions/spaghetti-3547078_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 6,
      categoryId: 3,
      name: 'Chicken Noodle Soup',
      price: 90,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '190',
      featured: false,
      rating: 3.0,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/113/soup-4115245_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/113/conversions/soup-4115245_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/113/conversions/soup-4115245_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 7,
      categoryId: 3,
      name: 'California Italian Wedding Soupp',
      price: 190,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '170',
      featured: false,
      rating: 3.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/115/soup-918422_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/115/conversions/soup-918422_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/115/conversions/soup-918422_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 8,
      categoryId: 2,
      name: 'Juicy Lucy Burgers',
      price: 140,
      discount: 0,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '190',
      featured: false,
      rating: 1.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/121/hamburger-1414423_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/121/conversions/hamburger-1414423_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/121/conversions/hamburger-1414423_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 9,
      categoryId: 2,
      name: 'Calas',
      price: 160,
      discount: 5,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '190',
      featured: false,
      rating: 3.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/54/food2.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/54/conversions/food2-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/54/conversions/food2-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
    new Food(
      id: 10,
      categoryId: 2,
      name: 'Cedar Planked Salmon',
      price: 180,
      discount: 5,
      excerpt: '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm.</p>',
      description:
          '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
      weight: '163',
      featured: false,
      rating: 3.5,
      image: new Media(
        id: 1,
        url:
            'https://multi-restaurants.smartersvision.com/storage/app/public/123/salmon-518032_1280.jpg',
        thumb:
            'https://multi-restaurants.smartersvision.com/storage/app/public/123/conversions/salmon-518032_1280-thumb.jpg',
        icon:
            'https://multi-restaurants.smartersvision.com/storage/app/public/123/conversions/salmon-518032_1280-icon.jpg',
      ),
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
            name: 'Barbara Glanz',
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
  ];
}
