

import 'Brewery.dart';
import 'Festival.dart';

class Coupon {
  final int id;
  final String type;
  final DateTime validUntil;
  final Brewery? brewery;
  final Festival? festival;

  Coupon(this.id, this.type, this.validUntil, this.brewery, this.festival);
}