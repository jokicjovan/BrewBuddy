import 'package:BrewBuddy/models/Beer.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

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
