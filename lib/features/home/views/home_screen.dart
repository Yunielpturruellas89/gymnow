import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymnow/features/auth/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(
                  context, '/login'); // Navigate to login
            },
          ),
        ],
      ),
      body: Center(
        child: authProvider.user != null
            ? Text('Welcome, ${authProvider.user!.name}!')
            : const Text('Loading user info...'),
      ),
    );
  }
}
