import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:BrewBuddy/pages/BreweryPage.dart';
import 'package:BrewBuddy/pages/FestivalPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'BeerPage.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  PopularPageState createState() => PopularPageState();
}

class PopularPageState extends State<PopularPage> {
  List<Beer> beers = [];
  List<Brewery> breweries = [];
  List<Festival> festivals = [];

  void getData() {
    beers = Beer.getBeers();
    breweries = Brewery.getBreweries();
    festivals = Festival.getFestivals();
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
              Text(
                "See more...",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
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
          const SizedBox(
            height: 20,
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
              Text(
                "See more...",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
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
          const SizedBox(
            height: 30,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 30),
              Expanded(
                  child: Text(
                "You should visit",
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
          ListView.separated(
            shrinkWrap: true,
            // Makes the ListView take only the necessary height
            physics: const NeverScrollableScrollPhysics(),
            // Disables scrolling of this ListView
            itemBuilder: (context, index) {
              return buildFestivalCard(index, context);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: breweries.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ],
      )),
    );
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
          Text(
            beers[index].name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 22,
            ),
          ),
          index < 3
              ? Image.asset(
                  index == 0
                      ? "assets/gold-medal.png"
                      : index == 1
                          ? "assets/silver-medal.png"
                          : "assets/bronze-medal.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : SizedBox(
                  height: 50,
                  child: Text(
                    "${index + 1}.",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
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
            "assets/brewery.png",
            width: 120,
            height: 120,
          ),
          Text(
            breweries[index].name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 22,
            ),
          ),
          index < 3
              ? Image.asset(
                  index == 0
                      ? "assets/gold-medal.png"
                      : index == 1
                          ? "assets/silver-medal.png"
                          : "assets/bronze-medal.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : SizedBox(
                  height: 50,
                  child: Text(
                    "${index + 1}.",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                )
        ],
      ),
    ));
  }

  GestureDetector buildFestivalCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FestivalPage(
                    festivalId: festivals[index].id,
                  )));
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 151, 151, 0.22),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  children: [
                    index < 3
                        ? Image.asset(
                            index == 0
                                ? "assets/gold-medal.png"
                                : index == 1
                                    ? "assets/silver-medal.png"
                                    : "assets/bronze-medal.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Text(
                                "${index + 1}.",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          festivals[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 22,
                          ),
                        ),
                        Row(
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
                              festivals[index].city.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                    Column(
                      children: [
                        Text(festivals[index].eventDate.day.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 22,
                            )),
                        Text(
                            DateFormat.MMM().format(festivals[index].eventDate),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
