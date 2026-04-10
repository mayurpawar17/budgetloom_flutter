import 'dart:convert';

import 'package:budgetloom/core/constants/api_constants.dart';
import 'package:budgetloom/core/utils/app_logger.dart';
import 'package:budgetloom/features/transcations/data/model/all_expenses_response.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_headers.dart';

class ApiRepository {
  Future<AllExpensesResponse> fetchData() async {
    final String apiUrl = ApiConstants.getAllExpense;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: await ApiHeaders.getHeaders(),
    );
    AppLogger.instance.i("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      return AllExpensesResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Token might be expired.");
    } else {
      throw Exception("Failed to load data");
    }
  }
}
