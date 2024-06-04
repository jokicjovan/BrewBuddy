import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:flutter/material.dart';

import '../widgets/BeerCard.dart';
import 'BeerPage.dart';


class BreweryPage extends StatefulWidget {
  final int breweryId;

  const BreweryPage({required this.breweryId, super.key});
  @override
  BreweryPageState createState() => BreweryPageState();
}

class BreweryPageState extends State<BreweryPage> {
  int breweryId=-1;
  @override
  void initState() {
    super.initState();
    breweryId=widget.breweryId;
  }
  late Brewery brewery;
  List<Beer> beers = [];


  void getData() {
    brewery = Brewery.getBreweries()[0];
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
                Image.asset(
                    "lib/assets/brewery.png",
                    height: 250,
                    fit:BoxFit.fill),

                const SizedBox(height: 25,),
                Text(
                  brewery.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 5,),
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


                const SizedBox(height: 25,),
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
            )));
  }
}
