
class City {
  final int id;
  final String name;
  final String postalCode;

  City({
    required this.id,
    required this.name,
    required this.postalCode,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final String name = json['name'];
    final String postalCode = json['postalCode'];

    return City(
      id: id,
      name: name,
      postalCode: postalCode,
    );
  }
}
