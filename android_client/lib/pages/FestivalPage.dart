import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
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
                      return buildBreweryCard(index, context);
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
                "lib/assets/beer.png",
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
                        "${beers[index].percentageOfAlcohol}%",
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
  GestureDetector buildBreweryCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BreweryPage(breweryId: breweries[index].id,)));
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
                "lib/assets/brewery.png",
                width: 120,
                height: 120,
              ),
              Column(
                children: [
                  Text(
                    breweries[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 22,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        beers[index].brewery.city.name,
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
            ],
          ),
        ));
  }
}
