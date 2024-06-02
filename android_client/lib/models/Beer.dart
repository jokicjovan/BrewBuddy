import 'Brewery.dart';
import 'City.dart';

class Beer {
  final int id;
  final String name;
  final double percentageOfAlcohol;
  final double ibu;
  final double price;
  final String type;
  final String imageName;
  final Brewery brewery;

  Beer({
    required this.id,
    required this.name,
    required this.percentageOfAlcohol,
    required this.ibu,
    required this.price,
    required this.type,
    required this.imageName,
    required this.brewery,
  });

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'] as int,
      name: json['name'] as String,
      percentageOfAlcohol: json['percentageOfAlcohol'] as double,
      ibu: json['ibu'] as double,
      price: json['price'] as double,
      type: json['type'] as String,
      imageName: json['imageName'] as String,
      brewery: Brewery.fromJson(json['brewery']),
    );
  }

  static List<Beer> getBeers() {
    List<Beer> beers = [];

    beers.add(Beer(
        id: 1,
        name: "JuiceIPA",
        percentageOfAlcohol: 6.0,
        ibu: 60,
        price: 0,
        type: "IPA",
        imageName: "",
        brewery: Brewery(
            id: 1,
            name: "3BIR",
            imageName: "",
            city: City(id: 1, name: "Novi Sad", postalCode: "22000"))));
    beers.add(Beer(
        id: 1,
        name: "Heineken",
        percentageOfAlcohol: 6.0,
        ibu: 60,
        price: 0,
        type: "IPA",
        imageName: "",
        brewery: Brewery(
            id: 1,
            name: "3BIR",
            imageName: "",
            city: City(id: 1, name: "Novi Sad", postalCode: "22000"))));
    beers.add(Beer(
        id: 1,
        name: "Bira",
        percentageOfAlcohol: 6.0,
        ibu: 60,
        price: 0,
        type: "IPA",
        imageName: "",
        brewery: Brewery(
            id: 1,
            name: "3BIR",
            imageName: "",
            city: City(id: 1, name: "Novi Sad", postalCode: "22000"))));
    return beers;
  }
}
