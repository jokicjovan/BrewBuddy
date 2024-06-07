import 'Brewery.dart';
import 'City.dart';

class Festival {
  final int id;
  final String name;
  final City city;
  final DateTime eventDate;
  final List<Brewery>? breweries;

  Festival({
    required this.id,
    required this.name,
    required this.city,
    required this.eventDate,
    this.breweries,
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['id'] as int,
      name: json['name'] as String,
      city: City.fromJson(json['city']),
      eventDate: DateTime.fromMillisecondsSinceEpoch(json['eventDate'] as int),
      breweries: (json['breweries'] as List<dynamic>?)
          ?.map((breweryJson) => Brewery.fromJson(breweryJson))
          .toList(),
    );
  }

  static List<Festival> getFestivals() {
    List<Festival> festivals = [];
    festivals.add(Festival(
        id: 1,
        name: "Beer Fest",
        city: City(id: 1, name: "Novi Sad", postalCode: "21000"),
        eventDate: DateTime(2024, 12, 12)));
    return festivals;
  }
}
