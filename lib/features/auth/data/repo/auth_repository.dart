import 'dart:convert';

import 'package:budgetloom/core/constants/api_constants.dart';
import 'package:budgetloom/core/utils/app_logger.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_headers.dart';
import '../../../../core/constants/token_manager.dart';
import '../model/user.dart';

class AuthRepository {
  Future<User> login(String email, String password) async {
    final apiUrl = ApiConstants.login;
    AppLogger.instance.i("Login API URL: $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final data = decoded['data'];

      await TokenManager.saveTokens(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );

      return User(
        id: '', // will be fetched from profile
        email: data['email'],
      );
    }

    throw Exception('Login Failed');
  }

  Future<User> getProfile() async {
    final response = await http.get(
      Uri.parse(ApiConstants.profile),
      headers: await ApiHeaders.getHeaders(),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final data = decoded['data'];

      return User(id: data['id'].toString(), email: data['email']);
    }

    throw Exception("Invalid token");
  }

  Future<void> logout() async {
    await TokenManager.clear();
  }
}
