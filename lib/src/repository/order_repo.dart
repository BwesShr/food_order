import 'package:food_order/src/repository/repository.dart';
import 'package:food_order/src/utils/functions.dart';

import '../models/model.dart';

final _functions = Functions();
getOrder() {
  return Order(
    id: 1,
    foodOrders: getFoodCart(),
    orderStatus: OrderStatus(id: 1, status: 'ordered'),
    tax: 10,
    deliveryFee: 50,
    dateTime: DateTime.now(),
    user: null,
    payment: null,
    deliveryAddress: getAddress(),
  );
}

List<Cart> getFoodCart() {
  return [
    new Cart(
      id: 1,
      userId: 1,
      quantity: 2,
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
        new Ingrident(
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
        description:
            '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
        weight: '245.3',
        featured: false,
        rating: 2.5,
        media: new Media(
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
              image:
                  'https://multi-restaurants.smartersvision.com/storage/app/public/67/user1.jpg',
            ),
          ),
        ],
      ),
    ),
    new Cart(
      id: 1,
      userId: 1,
      quantity: 1,
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
      ],
      food: new Food(
        id: 6,
        categoryId: 3,
        name: 'Chicken Noodle Soup',
        price: 90,
        discount: 0,
        description:
            '<p>A favorite of Minnesotans! The famous Juicy Lucy! Mmmm. So good. You MUST use American cheese on this to achieve the juiciness in the middle! I like sauteed mushrooms and onions on mine!<br></p>',
        weight: '190',
        featured: false,
        rating: 3.0,
        media: new Media(
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
              image:
                  'https://multi-restaurants.smartersvision.com/storage/app/public/67/user1.jpg',
            ),
          ),
        ],
      ),
    ),
  ];
}
