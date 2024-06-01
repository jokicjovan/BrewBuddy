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

  Beer(this.id, this.name, this.percentageOfAlcohol, this.ibu, this.price,
      this.type, this.imageName, this.brewery);

  static List<Beer> getBeers() {
    List<Beer> beers = [];

    beers.add(
        Beer(1, "JuiceIPA", 6.0, 60, 0, "IPA", "", Brewery(1,"3BIR","",City(1,"Novi Sad","22000")))
    );
    beers.add(
        Beer(2, "JuiceIPA", 6.0, 60, 0, "IPA", "", Brewery(1,"3BIR","",City(1,"Novi Sad","22000")))
    );
    beers.add(
        Beer(3, "JuiceIPA", 6.0, 60, 0, "IPA", "", Brewery(1,"3BIR","",City(1,"Novi Sad","22000")))
    );
    beers.add(
        Beer(4, "JuiceIPA", 6.0, 60, 0, "IPA", "", Brewery(1,"3BIR","",City(1,"Novi Sad","22000")))
    );
    beers.add(
        Beer(5, "JuiceIPA", 6.0, 60, 0, "IPA", "", Brewery(1,"3BIR","",City(1,"Novi Sad","22000")))
    );




    return beers;
  }
}


