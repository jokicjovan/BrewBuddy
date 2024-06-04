import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/services/BeerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateDialog extends StatefulWidget {
  final Function() onRatePressed;
  final Beer selectedBeer;
  const RateDialog({super.key, required this.selectedBeer, required this.onRatePressed});

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  final TextEditingController _commentController = TextEditingController(text: "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BeerService beerService = BeerService();
  double? selectedRate = 3.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    selectedRate = rating;
                  });
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your text here',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your comment';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                handleRateButtonClick();
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              child: const Text(
                "Rate",
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

  void handleRateButtonClick() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool success = await beerService.rateBeer(widget.selectedBeer, selectedRate!.round(),
          _commentController.text);
      if(success){
        widget.onRatePressed();
      }
    }
  }
}
