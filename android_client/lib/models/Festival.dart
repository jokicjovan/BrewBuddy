import 'Brewery.dart';
import 'City.dart';

class Festival{

  final int id;
  final String name;
  final City city;
  final DateTime date;
  final List<Brewery>? breweries;

  Festival(this.id, this.name, this.city, this.breweries, this.date);

}