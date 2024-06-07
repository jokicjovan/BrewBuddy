
import 'package:BrewBuddy/models/Festival.dart';
import 'package:BrewBuddy/pages/FestivalPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FestivalCard extends StatelessWidget {
  const FestivalCard({
    super.key,
    required this.festivals,
    required this.index,
  });

  final List<Festival> festivals;
  final int index;

  @override
  Widget build(BuildContext context) {
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

