import 'package:flutter/material.dart';

class DrunkWarningCard extends StatelessWidget {
  const DrunkWarningCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(225, 131, 131, 0.38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 60,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("You are probably drunk",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Text("Consider taking a nap",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
