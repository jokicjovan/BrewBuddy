

import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';

class Coupon {
  final int id;
  final String type;
  final DateTime validUntil;
  final double discountPercentage;
  final Brewery? brewery;
  final Festival? festival;

  Coupon({
    required this.id,
    required this.type,
    required this.validUntil,
    required this.discountPercentage,
    this.brewery,
    this.festival,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final String type = json['type'];
    final double discountPercentage = json['discountPercentage'] as double;
    final DateTime validUntil = DateTime.parse(json['validUntil']);
    final Map<String, dynamic>? breweryJson = json['brewery'];
    final Map<String, dynamic>? festivalJson = json['festival'];

    Brewery? brewery;
    Festival? festival;

    if (breweryJson != null) {
      brewery = Brewery.fromJson(breweryJson);
    }

    if (festivalJson != null) {
      festival = Festival.fromJson(festivalJson);
    }

    return Coupon(
      id: id,
      type: type,
      validUntil: validUntil,
      discountPercentage: discountPercentage,
      brewery: brewery,
      festival: festival,
    );
  }
}
