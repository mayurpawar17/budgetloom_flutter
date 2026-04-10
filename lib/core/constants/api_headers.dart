import 'package:budgetloom/core/constants/token_manager.dart';

class ApiHeaders {
  static Future<Map<String, String>> getHeaders() async {
    final token = await TokenManager.getAccessToken();

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
