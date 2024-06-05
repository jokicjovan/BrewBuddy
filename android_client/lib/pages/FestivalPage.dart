import 'dart:typed_data';

import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/City.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:BrewBuddy/services/FestivalService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:BrewBuddy/widgets/BreweryCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class FestivalPage extends StatefulWidget {
  final int festivalId;

  const FestivalPage({required this.festivalId, super.key});

  @override
  FestivalPageState createState() => FestivalPageState();
}

class FestivalPageState extends State<FestivalPage> {
  FestivalService festivalService = FestivalService();
  ImageService imageService = ImageService();

  int festivalId = -1;

  @override
  void initState() {
    super.initState();
    festivalId = widget.festivalId;
    getData();
  }

  Festival festival = Festival(
      id: -1,
      name: '',
      city: City(
        id: -1,
        name: '',
        postalCode: '',
      ),
      eventDate: DateTime(1970, 1, 1));
  List<Beer> beers = [];

  void getData() async {
    final festival = await festivalService.getFestival(festivalId);
    List<Beer> accumulatedBeers = [];
    for (int i = 0; i < festival.breweries!.length; i++) {
      final Uint8List img =
          await imageService.getBreweryImage(festival.breweries![i].imageName);
      festival.breweries?[i].image = img;
      for (int j = 0; j < festival.breweries![i].beers!.length; j++) {
        Beer newBeer = festival.breweries![i].beers![j];
        final Uint8List beerImg =
            await imageService.getBeerImage(newBeer.imageName);
        newBeer.image = beerImg;
        accumulatedBeers.add(newBeer);
      }
    }
    if (mounted) {
      setState(() {
        this.festival = festival;
        this.beers = accumulatedBeers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: festival.id != -1
                ? Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        festival.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            festival.city.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('dd MMM yyyy').format(festival.eventDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 30),
                          Expanded(
                              child: Text(
                            "Breweries",
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
                            return BreweryCard(
                                brewery: festival.breweries![index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 25,
                          ),
                          itemCount: festival.breweries!.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                        ),
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
                            "Beers",
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
