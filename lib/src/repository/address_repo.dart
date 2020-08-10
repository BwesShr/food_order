import 'package:food_order/src/model/address.dart';
import 'package:food_order/src/utils/constants.dart';

getAddress() {
  return new Address(
    id: 1,
    userId: 1,
    fullName: 'Biwesh Shrestha',
    mobile: '9860660020',
    city: 'Lokanthali',
    address: 'Ananda tol, Lokanthali-1, Madhyapur Thimi',
    latitude: 27.672659,
    longitude: 85.361029,
    type: Constants.addressTypeWork,
    isDefault: true,
  );
}

getAddresses() {
  return [
    new Address(
      id: 1,
      userId: 1,
      fullName: 'Biwesh Shrestha',
      mobile: '9860660020',
      city: 'Lokanthali',
      address: 'Ananda tol, Lokanthali-1, Madhyapur Thimi',
      latitude: 27.672659,
      longitude: 85.361029,
      type: Constants.addressTypeHome,
      isDefault: true,
    ),
    new Address(
      id: 2,
      userId: 1,
      fullName: 'Biwesh Shrestha',
      mobile: '9860660020',
      city: 'Chabahil',
      address: 'Charumati Bhawan, Gopikrishana Chowk',
      latitude: 27.672659,
      longitude: 85.361029,
      type: Constants.addressTypeWork,
      isDefault: false,
    ),
  ];
}
