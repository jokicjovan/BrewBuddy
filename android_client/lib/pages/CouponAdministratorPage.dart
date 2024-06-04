import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/Brewery.dart';
import '../models/Festival.dart';

class CouponAdministratorPage extends StatefulWidget {
  const CouponAdministratorPage({super.key});

  @override
  CouponAdministratorPageState createState() => CouponAdministratorPageState();
}

class CouponAdministratorPageState extends State<CouponAdministratorPage> {
  final TextEditingController _minBeersBController = TextEditingController();
  final TextEditingController _percentageBController = TextEditingController();
  final TextEditingController _expireInBController = TextEditingController();
  final TextEditingController _rangeDaysBController = TextEditingController();

  final TextEditingController _minBeersFController = TextEditingController();
  final TextEditingController _percentageFController = TextEditingController();
  final TextEditingController _expireInFController = TextEditingController();
  final TextEditingController _rangeDaysFController = TextEditingController();

  final TextEditingController _minBeersAController = TextEditingController();
  final TextEditingController _percentageAController = TextEditingController();
  final TextEditingController _expireInAController = TextEditingController();
  final TextEditingController _rangeDaysAController = TextEditingController();
  List<Brewery> breweries = [];
  List<Festival> festivals = [];
  late Brewery selectedBrewery;
  late Festival selectedFestival;

  @override
  void initState() {
    super.initState();
    breweries = Brewery.getBreweries();
    festivals = Festival.getFestivals();
    //fetchUserCoupons();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Container(
            padding: const EdgeInsets.only(left: 35, right: 35, bottom: 64),
            child: Column(children: [
              buildBreweryCoupon(context),
              const SizedBox(
                height: 25,
              ),
              buildFestivalCoupon(context),
              const SizedBox(
                height: 25,
              ),
              buildAppCoupon(context),
            ])),
      ),
    );
  }

  Column buildBreweryCoupon(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Minimum beers"),
          keyboardType: TextInputType.number,
          controller: _minBeersBController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Discount percentage"),
          keyboardType: TextInputType.number,
          controller: _percentageBController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Valid for (days)"),
          keyboardType: TextInputType.number,
          controller: _expireInBController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Range (days)"),
          keyboardType: TextInputType.number,
          controller: _rangeDaysFController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        DropdownSearch<Festival>(
          clearButtonProps: const ClearButtonProps(isVisible: true),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                labelText: 'Search for a festival',
                hintText: 'Type the festival name',
              ),
            ),
            itemBuilder: (context, brewery, isSelected) {
              return ListTile(
                title: Text(brewery.name),
              );
            },
          ),
          asyncItems: (String filter) => Future.value(festivals).then(
              (festivals) => festivals
                  .where((festival) => festival.name.contains(filter))
                  .toList()),
          itemAsString: (Festival f) => f.name,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Select a brewery",
            ),
          ),
          onChanged: (Festival? selectedBrewery) {
            setState(() {
              selectedFestival = selectedFestival;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
            backgroundColor: Theme.of(context).colorScheme.primary,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            'Generate Brewery Coupon',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Column buildFestivalCoupon(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Minimum beers"),
          keyboardType: TextInputType.number,
          controller: _minBeersFController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Discount percentage"),
          keyboardType: TextInputType.number,
          controller: _percentageFController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Valid for (days)"),
          keyboardType: TextInputType.number,
          controller: _expireInFController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Range (days)"),
          keyboardType: TextInputType.number,
          controller: _rangeDaysBController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        DropdownSearch<Brewery>(
          clearButtonProps: const ClearButtonProps(isVisible: true),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                labelText: 'Search for a brewery',
                hintText: 'Type the brewery name',
              ),
            ),
            itemBuilder: (context, brewery, isSelected) {
              return ListTile(
                title: Text(brewery.name),
              );
            },
          ),
          asyncItems: (String filter) => Future.value(breweries).then(
              (breweries) => breweries
                  .where((brewery) => brewery.name.contains(filter))
                  .toList()),
          itemAsString: (Brewery b) => b.name,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Select a festival",
            ),
          ),
          onChanged: (Brewery? selectedBrewery) {
            setState(() {
              this.selectedBrewery = selectedBrewery!;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
            backgroundColor: Theme.of(context).colorScheme.primary,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            'Generate Festival Coupon',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Column buildAppCoupon(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Minimum beers"),
          keyboardType: TextInputType.number,
          controller: _minBeersAController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Discount percentage"),
          keyboardType: TextInputType.number,
          controller: _percentageAController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Valid for (days)"),
          keyboardType: TextInputType.number,
          controller: _expireInAController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Range (days)"),
          keyboardType: TextInputType.number,
          controller: _rangeDaysAController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
            backgroundColor: Theme.of(context).colorScheme.primary,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            'Generate App Coupon',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
