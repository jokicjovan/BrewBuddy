import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}
class SearchPageState extends State<SearchPage>{

  List<Beer> beers = [];

  void getData() {
    beers = Beer.getBeers();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return const SingleChildScrollView(
        child: Column(
          children: [],
        ));
  }
}
