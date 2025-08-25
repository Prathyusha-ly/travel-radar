import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Function to fetch current user data using JWT
Future<Map<String, dynamic>> getCurrentUser(String jwtToken) async {
  final url = Uri.parse("https://travelradar.aero/wp-json/wp/v2/users/me");

  final response = await http.get(
    url,
    headers: {
      "Authorization": "Bearer $jwtToken",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch user data: ${response.statusCode}');
  }
}

// Example usage in a Flutter widget
class UserInfoWidget extends StatefulWidget {
  final String jwtToken;
  const UserInfoWidget({Key? key, required this.jwtToken}) : super(key: key);

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await getCurrentUser(widget.jwtToken);
      setState(() {
        userData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    if (userData == null) {
      return const Text("Failed to load user data.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name: ${userData!['name']}"),
        Text("Username: ${userData!['slug']}"),
        Text("Email: ${userData!['email']}"),
      ],
    );
  }
}
