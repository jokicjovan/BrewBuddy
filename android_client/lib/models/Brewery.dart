import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/City.dart';
import 'dart:typed_data';

class Brewery {
  final int id;
  final String name;
  final String imageName;
  final City city;
  final List<Beer>? beers;
  Uint8List? image;

  Brewery({
    required this.id,
    required this.name,
    required this.imageName,
    required this.city,
    this.beers,
    this.image
  });

  factory Brewery.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final String name = json['name'];
    final String imageName = json['imageName'];
    final City city = City.fromJson(json['city']);
    final List<dynamic>? beersJson = json['beers'];

    List<Beer>? beers;
    if (beersJson != null) {
      beers = beersJson.map((beerJson) => Beer.fromJson(beerJson)).toList();
    }

    return Brewery(
      id: id,
      name: name,
      imageName: imageName,
      city: city,
      beers: beers,
    );
  }

  static List<Brewery> getBreweries() {
    List<Brewery> breweries = [];

    breweries.add(Brewery(
        id: 1,
        name: "3BIR",
        imageName: "",
        city: City(id: 1, name: "Novi Sad", postalCode: "21000")));

    return breweries;
  }
}
