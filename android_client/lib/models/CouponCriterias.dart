class CouponCriterias {
  final Criteria festivalCriteria;
  final Criteria breweryCriteria;
  final Criteria appCriteria;

  CouponCriterias({
    required this.festivalCriteria,
    required this.breweryCriteria,
    required this.appCriteria,
  });

  factory CouponCriterias.fromJson(Map<String, dynamic> json) {
    return CouponCriterias(
      appCriteria: Criteria.fromJson(json['appCriteria']),
      breweryCriteria: Criteria.fromJson(json['breweryCriteria']),
      festivalCriteria: Criteria.fromJson(json['festivalCriteria']),
    );
  }
}

class Criteria {
  final int id;
  final String type;
  final int minBeers;
  final double percentage;
  final int expireIn;
  final int daysRange;

  Criteria(
      {required this.id,
      required this.type,
      required this.minBeers,
      required this.percentage,
      required this.expireIn,
      required this.daysRange});

  factory Criteria.fromJson(Map<String, dynamic> json) {
    return Criteria(
      id: json['id'] as int,
      type: json['type'],
      minBeers: json['minBeers'] as int,
      percentage: json['percentage'] as double,
      expireIn: json['expireIn'] as int,
      daysRange: json['daysRange'] as int
    );
  }

}
