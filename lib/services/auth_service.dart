import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart'; // Make sure kBaseUrl is defined here

class AuthService {
  AuthService();

  String? _token; // Stores JWT token locally

  // WordPress JWT login endpoint
 
  Future<String> login(String username, String password, {required String username , required String password}) async {
    final uri = Uri.parse('$kBaseUrl/jwt-auth/v1/token');

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final token = (data['token'] ?? '').toString();
      if (token.isEmpty) {
        throw Exception('No token in response');
      }
      _token = token; // Save token locally
      return token;
    }

    throw Exception('Login failed: ${res.statusCode} ${res.body}');
  }

  // Logout by clearing token
  void logout() {
    _token = null;
  }

  // Get saved token
  String? get token => _token;
}
