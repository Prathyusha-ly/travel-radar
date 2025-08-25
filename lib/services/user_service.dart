import 'dart:convert';
import 'package:http/http.dart' as http;

// Model class for WPUser
class WPUser {
  final int id;
  final String name;
  final String username;
  final String email;

  WPUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory WPUser.fromJson(Map<String, dynamic> json) {
    return WPUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['slug'] ?? '',
      email: json['email'] ?? '',
    );
  }

  get avatarUrl => null;
}

// Service class to fetch current user
class UserService {
  UserService();

  Future<WPUser> me(String jwtToken) async {
    final url = Uri.parse('https://travelradar.aero/wp-json/wp/v2/users/me?context=edit');

    final res = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      return WPUser.fromJson(map);
    }

    throw Exception('Fetch current user failed: ${res.statusCode} ${res.body}');
  }
}

// Example usage:
// final userService = UserService();
// final user = await userService.me(FFAppState().currentUserAuthToken);
// print(user.name);
