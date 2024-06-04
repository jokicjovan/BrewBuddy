import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:BrewBuddy/widgets/BreweryCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'BeerPage.dart';
import 'BreweryPage.dart';


class FestivalPage extends StatefulWidget {
  final int festivalId;

  const FestivalPage({required this.festivalId, super.key});
  @override
  FestivalPageState createState() => FestivalPageState();
}

class FestivalPageState extends State<FestivalPage> {
  int festivalId=-1;
  @override
  void initState() {
    super.initState();
    festivalId=widget.festivalId;
  }
  late Festival festival;
  List<Beer> beers = [];
  List<Brewery> breweries = [];


  void getData() {
    festival = Festival.getFestivals()[0];
    breweries = Brewery.getBreweries();
    beers = Beer.getBeers();
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
            child: Column(

              children: [
                const SizedBox(height: 25,),
                Text(
                  festival.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 35,
                  ),
                ),

                const SizedBox(height: 10,),
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
                const SizedBox(height: 10,),
                Text(
                  DateFormat('dd MMM yyyy').format(festival.eventDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 30,),
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
                      return BreweryCard(brewery: breweries[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 25,
                    ),
                    itemCount: breweries.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  ),
                ),


                const SizedBox(height: 25,),
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
            )));
  }
}
