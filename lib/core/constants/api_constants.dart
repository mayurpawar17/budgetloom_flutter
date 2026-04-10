class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://192.168.2.160:8080/v1';
  static const String stagingUrl = 'https://staging-api.example.com/v1';

  // Auth Endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String refreshToken = '$baseUrl/auth/refresh-token';
  static const String profile = '$baseUrl/auth/profile';

  //Expense
  static const String createExpense = '$baseUrl/expenses';
  static const String getAllExpense = '$baseUrl/expenses';
  static const String updateExpense = '$baseUrl/expenses';
  static const String deleteExpense = '$baseUrl/expenses';
  static const String categoryExpense = '$baseUrl/expenses/analytics/category';
  static const String currentMonthTotal =
      '$baseUrl/expenses/current-month-total';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateAvatar = '/user/update-avatar';

  // Feature Endpoints (e.g., Posts)
  static const String posts = '/posts';
  static const String postDetails =
      '/posts/'; // Append ID: ApiConstants.postDetails + id

  // Headers
  static Map<String, String> headers(String? token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };
}
