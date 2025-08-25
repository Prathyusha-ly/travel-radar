import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:t_r_test_project_n_o_t_prod/main.dart';
import 'package:t_r_test_project_n_o_t_prod/state/auth_provider.dart';
import 'package:travel_radar_app/main.dart';
import 'package:travel_radar_app/providers/auth_provider.dart';

void main() {
  testWidgets('Login → Profile → Logout flow test', (WidgetTester tester) async {
    // Wrap MyApp with Provider if your AuthProvider is used globally
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
        child: const MyApp(),
      ),
    );

    // Wait for the app to build
    await tester.pumpAndSettle();

    // --- LOGIN PHASE ---
    // Enter username
    await tester.enterText(find.byKey(const Key('usernameField')), 'testuser');

    // Enter password
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');

    // Tap login button
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();

    // Check that Profile page is shown (example: contains user's name)
    expect(find.text('Test User'), findsOneWidget);

    // --- PROFILE PHASE ---
    // Verify avatar is displayed if present
    expect(find.byType(CircleAvatar), findsWidgets);

    // Verify email is displayed
    expect(find.text('testuser@example.com'), findsOneWidget);

    // --- LOGOUT PHASE ---
    // Tap logout button
    await tester.tap(find.byKey(const Key('logoutButton')));
    await tester.pumpAndSettle();

    // After logout, Login page should be visible again
    expect(find.byKey(const Key('loginButton')), findsOneWidget);
  });
}
