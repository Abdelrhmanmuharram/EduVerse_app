import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String onboardingKey = 'on_boarding_seen';

  static Future<void> setOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
  }

  static Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  // ─── Access Token ────────────────────────────────────────────────────────────
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  // ─── Access Token Expiry ─────────────────────────────────────────────────────
  // Stored as ISO-8601 string, e.g. "2026-05-30T17:18:40Z"
  static Future<void> saveTokenExpiry(String expiry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("tokenExpiry", expiry);
  }

  static Future<DateTime?> getTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString("tokenExpiry");
    return raw != null ? DateTime.tryParse(raw)?.toUtc() : null;
  }

  // ─── Refresh Token ───────────────────────────────────────────────────────────
  static Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  // ─── Refresh Token Expiry ────────────────────────────────────────────────────
  // Stored as ISO-8601 string, e.g. "2026-06-06T17:13:40.531Z"
  static Future<void> saveRefreshTokenExpiry(String expiry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("refreshTokenExpiry", expiry);
  }

  static Future<DateTime?> getRefreshTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString("refreshTokenExpiry");
    return raw != null ? DateTime.tryParse(raw)?.toUtc() : null;
  }

  // ─── Role ────────────────────────────────────────────────────────────────────
  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("role", role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  // ─── Clear all auth data on logout ───────────────────────────────────────────
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("tokenExpiry");
    await prefs.remove("refreshToken");
    await prefs.remove("refreshTokenExpiry");
  }
}