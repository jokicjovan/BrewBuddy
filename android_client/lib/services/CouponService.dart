import 'dart:convert';
import 'package:BrewBuddy/models/Coupon.dart';
import 'package:http/http.dart' as http;
import 'package:BrewBuddy/assets/constants.dart';

class CouponService {

  Future<List<Coupon>> getUserCoupons() async {
    final response = await http.get(Uri.parse('$baseUrl/user/coupon'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Coupon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user coupons');
    }
  }
}