import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  WPUser? me;
  bool isLoggedIn = false;

  final AuthService _authService = AuthService();
  final UserService _userService = UserService(); // ✅ Ensure UserService exists and is imported

  // Load session if token exists
  Future<void> tryLoadSession() async {
    final token = _authService.token;
    if (token != null) {
      me = await _userService.me(token);
      isLoggedIn = me != null;
      notifyListeners();
    }
  }

  // Login and fetch user info
  Future<void> login(String username, String password) async {
    final token = await _authService.login(username, password, username: '', password: '');
    me = await _userService.me(token);
    isLoggedIn = true;
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    _authService.logout();
    me = null;
    isLoggedIn = false;
    notifyListeners();
  }
}
