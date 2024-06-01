import 'package:BrewBuddy/models/Coupon.dart';
import 'package:flutter/material.dart';

class CouponPage extends StatefulWidget{
  const CouponPage({super.key});

  @override
  CouponPageState createState() => CouponPageState();
}

class CouponPageState extends State<CouponPage>{
  List<Coupon> userCoupons = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCard(context, 'Card 1'),
        _buildCard(context, 'Card 2'),
        _buildCard(context, 'Card 3'),
      ],
    ),
    );
  }

  Widget _buildCard(BuildContext context, String title) {
    return InkWell(
      onTap: () {

      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}