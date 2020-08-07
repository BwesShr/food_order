import 'package:food_order/src/model/walkthrough.dart';

Future<List<Walkthrough>> getWalkthroughs() async {
  return [
    new Walkthrough(
      title: 'Fresh Foods',
      subtitle:
          'Fresh food is food which has not been preserved and has not spoiled yet. ',
      image: 'assets/images/delivering_boy.jpg',
      backgroundImage: 'assets/images/pizza_wallpaper.jpg',
    ),
    new Walkthrough(
      title: 'Fresh Foods',
      subtitle:
          'Fresh food is food which has not been preserved and has not spoiled yet. ',
      image: 'assets/images/pizza_delivery.jpg',
      backgroundImage: 'assets/images/pizza_wallpaper.jpg',
    ),
    new Walkthrough(
      title: 'Fresh Foods',
      subtitle:
          'Fresh food is food which has not been preserved and has not spoiled yet. ',
      image: 'assets/images/scooter_delivery.jpg',
      backgroundImage: 'assets/images/pizza_wallpaper.jpg',
    ),
  ];
}
