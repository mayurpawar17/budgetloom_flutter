import 'dart:convert';

import 'package:budgetloom/core/utils/app_logger.dart';
import 'package:budgetloom/features/expense/data/model/category_expense_response.dart';
import 'package:budgetloom/features/expense/data/model/current_month_total_response.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/api_headers.dart';

class ExpenseRepository {
  Future<CurrentMonthTotalResponse> getCurrentMonthTotal() async {
    final apiUrl = ApiConstants.currentMonthTotal;
    AppLogger.instance.i("Current Month Total API URL: $apiUrl");
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: await ApiHeaders.getHeaders(),
      );
      AppLogger.instance.i("Expense Total Response: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CurrentMonthTotalResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        // Handle token expiration: potentially trigger a logout
        throw Exception("Unauthorized: Session expired");
      } else {
        throw Exception("Failed to load total: ${response.body}");
      }
    } catch (e) {
      AppLogger.instance.e("Error fetching expense total: $e");
      rethrow;
    }
  }

  Future<CategoryExpenseResponse> getCategoryAnalytics() async {
    final apiUrl = ApiConstants.categoryExpense;
    AppLogger.instance.i("Category Analytics Expense API URL: $apiUrl");

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: await ApiHeaders.getHeaders(),
    );
    AppLogger.instance.i("Category Analytics Response: ${response.body}");
    if (response.statusCode == 200) {
      return CategoryExpenseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch analytics: ${response.statusCode}");
    }
  }

  Future<CategoryExpenseResponse> createExpense(String title) async {
    final apiUrl = ApiConstants.createExpense;
    AppLogger.instance.i("Create Expense API URL: $apiUrl");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: await ApiHeaders.getHeaders(),
        body: jsonEncode({'title': title}),
      );

      AppLogger.instance.i("Create Expense Response: ${response.body}");
      return CategoryExpenseResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception("Failed to create expense: $e");
    }
  }
}
