import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class AuthService {
  static const _savedUserKey = 'remembered_username';
  static const _savedAccountsKey = 'orbit_accounts';
  static const _demoUsername = 'demo';
  static const _demoEmail = 'demo@orbit.app';
  static const _demoPassword = 'password123';

  Future<String?> restoreSession() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_savedUserKey);
  }

  Future<bool> signIn({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();
    final preferences = await SharedPreferences.getInstance();

    String? displayName;
    if ((normalizedUsername == _demoUsername ||
            normalizedUsername == _demoEmail) &&
        password == _demoPassword) {
      displayName = 'Demo User';
    } else {
      final accounts = _decodeAccounts(preferences);
      for (final account in accounts) {
        final storedEmail = (account['email'] as String).toLowerCase();
        if (storedEmail == normalizedUsername &&
            account['password'] == password) {
          displayName = account['name'] as String?;
          break;
        }
      }
    }
    if (displayName == null) return false;

    if (rememberMe) {
      await preferences.setString(_savedUserKey, displayName);
    } else {
      await preferences.remove(_savedUserKey);
    }
    return true;
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final trimmedName = name.trim();
    final normalizedEmail = email.trim().toLowerCase();
    if (trimmedName.isEmpty ||
        !_isValidEmail(normalizedEmail) ||
        password.length < 6) {
      return false;
    }

    final preferences = await SharedPreferences.getInstance();
    final accounts = _decodeAccounts(preferences);
    final alreadyExists = accounts.any(
      (account) =>
          (account['email'] as String).toLowerCase() == normalizedEmail,
    );
    if (alreadyExists ||
        normalizedEmail == _demoUsername ||
        normalizedEmail == _demoEmail) {
      return false;
    }

    accounts.add({
      'name': trimmedName,
      'email': normalizedEmail,
      'password': password,
    });
    await preferences.setString(_savedAccountsKey, jsonEncode(accounts));
    if (rememberMe) {
      await preferences.setString(_savedUserKey, trimmedName);
    } else {
      await preferences.remove(_savedUserKey);
    }
    return true;
  }

  Future<void> signOut() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_savedUserKey);
  }

  List<Map<String, dynamic>> _decodeAccounts(SharedPreferences preferences) {
    final raw = preferences.getString(_savedAccountsKey);
    if (raw == null || raw.isEmpty) return <Map<String, dynamic>>[];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return <Map<String, dynamic>>[];
    return decoded.whereType<Map>().map((account) {
      return Map<String, dynamic>.from(account);
    }).toList();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }
}
