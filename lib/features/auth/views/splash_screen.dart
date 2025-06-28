import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymnow/features/auth/providers/auth_provider.dart';
import 'login_screen.dart';
import 'package:gymnow/features/home/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate splash screen delay

    if (await authProvider.hasToken()) {
      try {
        await authProvider.loadUser(); // Attempt to load user data
        if (authProvider.user != null) {
          // User is logged in, navigate to home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Token exists but user data could not be loaded, navigate to login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } catch (e) {
        // Exception occurred, navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } else {
      // No token, navigate to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'), // Replace with your splash screen UI
      ),
    );
  }
}
