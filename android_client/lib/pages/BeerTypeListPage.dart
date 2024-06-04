import 'dart:typed_data';

import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/services/BeerService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:flutter/material.dart';


class BeerTypeListPage extends StatefulWidget {
  final String beerType;

  const BeerTypeListPage({required this.beerType, super.key});

  @override
  BeerTypeListPageState createState() => BeerTypeListPageState();
}

class BeerTypeListPageState extends State<BeerTypeListPage> {
  late String beerType;
  BeerService beerService= BeerService();
  ImageService imageService= ImageService();
  List<Beer> beers=[];

  Future<void> getBeers(String type) async {
    final beers = await beerService.getBeersByType(type);
    for (int i = 0; i < beers.length; i++) {
      final Uint8List img = await imageService.getBeerImage(beers[i].imageName);
      beers[i].image = img;
    }
    setState(() {
      this.beers = beers;
    });
  }

  @override
  void initState() {
    super.initState();
    beerType = widget.beerType;
    getBeers(beerType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("BrewBuddy"),
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.681,

          ),


          itemCount: beers.length,
          itemBuilder: (context, index) {
            return BeerCard(beer: beers[index]);
          },
        ),
      ),
    );
  }
}
