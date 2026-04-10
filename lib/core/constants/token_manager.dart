import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();

  static const _accessKey = 'accessToken';
  static const _refreshKey = 'refreshToken';

  /// Save tokens
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  /// Get access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessKey);
  }

  /// Get refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshKey);
  }

  /// Clear tokens (logout)
  static Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}
