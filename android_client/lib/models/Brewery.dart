import 'City.dart';

class Brewery{

  final int id;
  final String name;
  final String imageName;
  final City city;

  Brewery(this.id, this.name, this.imageName,this.city);

  static List<Brewery> getBreweries() {
    List<Brewery> breweries = [];
    
    breweries.add(Brewery(1, "3BIR", "", City(1,"Novi Sad","21000")));
    breweries.add(Brewery(2, "3BIR", "", City(1,"Novi Sad","21000")));
    breweries.add(Brewery(3, "3BIR", "", City(1,"Novi Sad","21000")));
    breweries.add(Brewery(4, "3BIR", "", City(1,"Novi Sad","21000")));

    return breweries;
    
  }
}