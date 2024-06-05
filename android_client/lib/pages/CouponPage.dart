import 'package:BrewBuddy/models/Coupon.dart';
import 'package:BrewBuddy/services/CouponService.dart';
import 'package:BrewBuddy/widgets/RibbedVerticalDivider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  CouponPageState createState() => CouponPageState();
}

class CouponPageState extends State<CouponPage> {
  CouponService couponService = CouponService();
  List<Coupon> userCoupons = [];

  @override
  void initState() {
    super.initState();
    fetchUserCoupons();
  }

  Future<void> fetchUserCoupons() async {
    final coupons = await couponService.getUserCoupons();
    if (mounted) {
      setState(() {
        userCoupons = coupons;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 64.0),
        itemCount: userCoupons.length,
        itemBuilder: (context, index) {
          return _buildCard(context, userCoupons[index]);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Coupon coupon) {
    String title;
    String type;
    switch (coupon.type) {
      case "BREWERY":
        title = coupon.brewery?.name ?? 'Unknown Brewery';
        type = "Brewery coupon";
        break;
      case "FESTIVAL":
        title = coupon.festival?.name ?? 'Unknown Festival';
        type = "Festival coupon";
        break;
      default:
        title = 'Discount in app';
        type = "Application Coupon";
    }

    return InkWell(
        onTap: () {},
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Valid until ${DateFormat('yyyy/MM/dd').format(coupon.validUntil)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    RibbedVerticalDivider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1.2,
                      dashLength: 6.0,
                      gapLength: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0,top: 16.0,bottom: 16.0),
                      child: Container(
                        width: 80,
                        child: Text(
                          "${coupon.discountPercentage.round()}%",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
