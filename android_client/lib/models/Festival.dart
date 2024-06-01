

import 'package:android_client/models/BrewerySimple.dart';

import 'City.dart';

class Festival{

  final int id;
  final String name;
  final City city;
  final List<BrewerySimple> breweries;
  final DateTime date;

  Festival(this.id, this.name, this.city, this.breweries, this.date);

}