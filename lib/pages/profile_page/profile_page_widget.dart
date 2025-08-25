import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:t_r_test_project_n_o_t_prod/state/auth_provider.dart';
import '../../providers/auth_provider.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.me;

    if (!auth.isLoggedIn) {
      Future.microtask(() => context.goNamed('LoginPage'));
      return const SizedBox.shrink();
    }

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (user.avatarUrl != null)
            CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(user.avatarUrl!),
            ),
          const SizedBox(height: 12),
          Text(user.name, style: Theme.of(context).textTheme.titleLarge),
          if (user.email != null) Text(user.email!),
          const SizedBox(height: 24),
          ElevatedButton(
            key: const Key('logoutButton'),
            onPressed: () => context.read<AuthProvider>().logout(),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
