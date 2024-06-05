import 'dart:typed_data';

import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/City.dart';
import 'package:BrewBuddy/services/BreweryService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:flutter/material.dart';

import '../widgets/BeerCard.dart';

class BreweryPage extends StatefulWidget {
  final int breweryId;

  const BreweryPage({required this.breweryId, super.key});

  @override
  BreweryPageState createState() => BreweryPageState();
}

class BreweryPageState extends State<BreweryPage> {
  BreweryService breweryService = BreweryService();
  ImageService imageService = ImageService();
  int breweryId = -1;

  @override
  void initState() {
    super.initState();
    breweryId = widget.breweryId;
    getData();
  }

  Brewery brewery = Brewery(
      id: -1,
      name: '',
      imageName: '',
      city: City(id: -1, name: '', postalCode: ''));
  List<Beer> beers = [];

  void getData() async {
    final brewery = await breweryService.getBrewery(breweryId);
    Uint8List img = await imageService.getBreweryImage(brewery.imageName);
    brewery.image = img;
    for (int i = 0; i < brewery.beers!.length; i++) {
      final Uint8List img = await imageService.getBeerImage(brewery.beers![i].imageName);
      brewery.beers?[i].image = img;
    }
    if (mounted) {
      setState(() {
        this.brewery = brewery;
        this.beers = brewery.beers!;
      });
    }
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
        body: SingleChildScrollView(
            child: brewery.id != -1
                ? Column(
                    children: [
                      brewery.image != null
                          ? Image.memory(
                              brewery.image ?? Uint8List(0),
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : const Text("Missing Image"),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        brewery.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            brewery.city.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 30),
                          Expanded(
                              child: Text(
                            "Our Beers",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return BeerCard(beer: beers[index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 25,
                          ),
                          itemCount: beers.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )));
  }
}
