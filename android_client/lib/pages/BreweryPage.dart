import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'BeerPage.dart';


class BreweryPage extends StatefulWidget {
  final int breweryId;

  const BreweryPage({required this.breweryId, Key? key}) : super(key: key);
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
                    "assets/brewery.png",
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
                Container(
                  height: 220,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return buildBeerCard(index, context);
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

  GestureDetector buildBeerCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BeerPage(beerId: beers[index].id,)));
    },
    child:Container(
      width: 150,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(151, 151, 151, 0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/beer.png",
            width: 120,
            height: 120,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    beers[index].type,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    beers[index].percentageOfAlcohol.toString() + "%",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                beers[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 22,
                ),
              ),
              const Text(
                "Powered By",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Text(
                beers[index].brewery.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
