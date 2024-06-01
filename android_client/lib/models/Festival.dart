import 'Brewery.dart';
import 'City.dart';

class Festival{

  final int id;
  final String name;
  final City city;
  final DateTime date;
  final List<Brewery>? breweries;

  Festival(this.id, this.name, this.city, this.breweries, this.date);

  static List<Festival> getFestivals() {
    List<Festival> festivals = [];
    festivals.add(Festival(1, "Beer Fest", City(1,"Novi Sad","21000"), [], DateTime(2024,12,12)));
    festivals.add(Festival(1, "Beer Fest", City(1,"Novi Sad","21000"), [], DateTime(2024,12,12)));
    festivals.add(Festival(1, "Beer Fest", City(1,"Novi Sad","21000"), [], DateTime(2024,12,12)));
    festivals.add(Festival(1, "Beer Fest", City(1,"Novi Sad","21000"), [], DateTime(2024,12,12)));

    return festivals;
  }

}