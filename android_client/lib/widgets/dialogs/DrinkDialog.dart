import 'package:BrewBuddy/services/BeerService.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:BrewBuddy/models/Beer.dart';

class DrinkDialog extends StatefulWidget {
  final Function(Beer selectedBeer, bool isBeerRated) onDrinkPressed;

  const DrinkDialog({super.key, required this.onDrinkPressed});

  @override
  DrinkDialogState createState() => DrinkDialogState();
}

class DrinkDialogState extends State<DrinkDialog> {
  BeerService beerService = BeerService();
  Beer? selectedBeer;
  bool buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownSearch<Beer>(
                clearButtonProps: const ClearButtonProps(isVisible: true),
                popupProps: const PopupProps.dialog(showSearchBox: true),
                asyncItems: (String filter) async => (await beerService.getPopularBeers())
                    .where((beer) => beer.name.contains(filter))
                    .toList(),
                itemAsString: (Beer u) => u.name,
                onChanged: (Beer? data) {
                  setState(() {
                    selectedBeer = data;
                  });
                },
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Select Beer",
                    hintText: "Select beer to log",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (buttonClicked && selectedBeer == null)
              const Text(
                "Please select a beer",
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                handleDrinkButtonClick();
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              child: const Text(
                "Drink!",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleDrinkButtonClick() async {
    setState(() {
      buttonClicked = true;
    });
    if (selectedBeer != null) {
      bool success = await beerService.logBeer(selectedBeer!);
      if (success){
        bool isBeerRated = await beerService.isBeerRated(selectedBeer!);
        widget.onDrinkPressed(selectedBeer!, isBeerRated);
      }
    }
  }
}
