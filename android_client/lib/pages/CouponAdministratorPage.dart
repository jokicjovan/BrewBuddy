import 'package:BrewBuddy/services/BreweryService.dart';
import 'package:BrewBuddy/services/CouponService.dart';
import 'package:BrewBuddy/services/FestivalService.dart';
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
  BreweryService breweryService = BreweryService();
  FestivalService festivalService = FestivalService();
  CouponService couponService = CouponService();
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
  Brewery? selectedBrewery;
  Festival? selectedFestival;

  Future<void> fetchData() async {
    final breweries = await breweryService.getBreweries();
    final festivals = await festivalService.getFestivals();
    setState(() {
      this.breweries = breweries;
      this.festivals = festivals;
    });
  }

  Future<void> generateBreweryCoupons() async {
    final isSuccess = await couponService.generateBreweryCoupon(
        int.parse(_minBeersBController.text),
        double.parse(_percentageBController.text),
        int.parse(_expireInBController.text),
        int.parse(_rangeDaysBController.text),
        this.selectedBrewery!.id);
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generated coupons successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> generateFestivalCoupons() async {
    final isSuccess = await couponService.generateFestivalCoupon(
        int.parse(_minBeersFController.text),
        double.parse(_percentageFController.text),
        int.parse(_expireInFController.text),
        int.parse(_rangeDaysFController.text),
        this.selectedFestival!.id);
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generated coupons successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> generateAppCoupons() async {
    final isSuccess = await couponService.generateAppCoupon(
        int.parse(_minBeersAController.text),
        double.parse(_percentageAController.text),
        int.parse(_expireInAController.text),
        int.parse(_rangeDaysAController.text));
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generated coupons successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
          selectedItem: this.selectedBrewery,
          asyncItems: (String filter) => Future.value(breweries).then(
              (breweries) => breweries
                  .where((brewery) => brewery.name.contains(filter))
                  .toList()),
          itemAsString: (Brewery b) => b.name,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Select a brewery",
            ),
          ),
          onChanged: (Brewery? selectedBrewery) {
            setState(() {
              this.selectedBrewery = selectedBrewery;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            generateBreweryCoupons();
          },
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
            itemBuilder: (context, festival, isSelected) {
              return ListTile(
                title: Text(festival.name),
              );
            },
          ),
          selectedItem: this.selectedFestival,
          asyncItems: (String filter) => Future.value(festivals).then(
              (festivals) => festivals
                  .where((festival) => festival.name.contains(filter))
                  .toList()),
          itemAsString: (Festival f) => f.name,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Select a festival",
            ),
          ),
          onChanged: (Festival? selectedFestival) {
            setState(() {
              this.selectedFestival = selectedFestival;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            generateFestivalCoupons();
          },
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
          onPressed: () {
            generateAppCoupons();
          },
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
