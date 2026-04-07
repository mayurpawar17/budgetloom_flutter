import 'dart:convert';

import 'package:budgetloom/features/transcations/data/model/all_expenses_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository {
  final String baseUrl = "http://192.168.2.160:8080/api/expenses";

  Future<AllExpensesResponse> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');


    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Response Body: ${response.body}");
      return AllExpensesResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Token might be expired.");
    } else {
      throw Exception("Failed to load data");
    }
  }
}
