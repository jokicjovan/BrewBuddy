import 'Brewery.dart';

class Beer {
  final int id;
  final String name;
  final double percentageOfAlcohol;
  final double ibu;
  final double price;
  final String type;
  final String imageName;
  final Brewery brewery;

  Beer(this.id, this.name, this.percentageOfAlcohol, this.ibu, this.price,
      this.type, this.imageName, this.brewery);

}


