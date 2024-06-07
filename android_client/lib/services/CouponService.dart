import 'dart:convert';
import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Coupon.dart';
import 'package:BrewBuddy/assets/constants.dart';
import 'package:BrewBuddy/models/CouponCriterias.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class CouponService {
  final String couponServiceUrl="$baseUrl/coupon";
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<bool> generateBreweryCoupon(int minBeers,double percentage, int validFor, int range, int breweryId) async {


    final url = Uri.parse('$couponServiceUrl/brewery');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'minBeers': minBeers,
        'percentage': percentage,
        'validFor': validFor,
        'range': range,
        'id': breweryId,
      }),
    );
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
  Future<bool> generateFestivalCoupon(int minBeers,double percentage, int validFor, int range, int festivalId) async {
    final url = Uri.parse('$couponServiceUrl/festival');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'minBeers': minBeers,
        'percentage': percentage,
        'validFor': validFor,
        'range': range,
        'id': festivalId,
      }),
    );
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> generateAppCoupon(int minBeers,double percentage, int validFor, int range) async {
    final url = Uri.parse('$couponServiceUrl/application');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'minBeers': minBeers,
        'percentage': percentage,
        'validFor': validFor,
        'range': range,
      }),
    );
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }


  Future<List<Coupon>> getUserCoupons() async {
    final response = await client.get(Uri.parse('$baseUrl/user/coupon'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Coupon.fromJson(json)).toList();
    }
    throw Exception("Exception while getting user coupons: ${response.reasonPhrase}");
  }

  Future<CouponCriterias> getCouponCriterias() async {
    final response = await client.get(Uri.parse('$baseUrl/coupon/criteria'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CouponCriterias.fromJson(jsonData);
    }
    throw Exception("Exception while getting coupon criterias: ${response.reasonPhrase}");
  }
}