import 'dart:convert';
import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Coupon.dart';
import 'package:BrewBuddy/assets/constants.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class CouponService {
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);


  Future<List<Coupon>> getUserCoupons() async {
    final response = await client.get(Uri.parse('$baseUrl/user/coupon'));
    print("Kuponi");
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Coupon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user coupons');
    }
  }
}