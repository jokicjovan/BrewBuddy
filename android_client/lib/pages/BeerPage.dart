import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/pages/BreweryPage.dart';
import 'package:flutter/material.dart';


class BeerPage extends StatefulWidget {
  final int beerId;

  const BeerPage({required this.beerId, super.key});
  @override
  BeerPageState createState() => BeerPageState();
}

class BeerPageState extends State<BeerPage> {
  int beerId=-1;
  @override
  void initState() {
    super.initState();
    beerId=widget.beerId;
  }
  late Beer beer;
  List<Beer> beers = [];


  void getData() {
    beer = Beer.getBeers()[0];
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
              "assets/beer.png",
              height: 250,
                fit:BoxFit.fill),

            const SizedBox(height: 25,),
            Text(
              beer.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BreweryPage(breweryId: beer.brewery.id,)));
                },
                child:
                SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          "assets/brewery.png",
                          height: 120,
                          fit:BoxFit.fill),
                      Text(
                        beer.brewery.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  height: 150,
                  child: VerticalDivider(
                    color: Color.fromRGBO(151, 151, 151, 0.8),
                    thickness: 1.2,
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        beer.type,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [Column(
                          children: [
                            const Text(
                              "IBU",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 20,
                              )),
                            Text(
                              beer.ibu.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 23,
                              )),
                          ],
                        ),
                          const SizedBox(width: 20,),
                          Column(
                            children: [
                              const Text("ALC",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                              Text("${beer.percentageOfAlcohol}%",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 23,
                              ),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 25,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 30),
                Expanded(
                    child: Text(
                  "Similar Beers",
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
        child:
        Container(
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
}
