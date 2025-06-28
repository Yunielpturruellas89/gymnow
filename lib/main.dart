import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymnow/features/auth/providers/auth_provider.dart';
import 'package:gymnow/features/auth/viewmodels/login_viewmodel.dart';
import 'package:gymnow/features/auth/views/splash_screen.dart'; // Import SplashScreen
import 'package:gymnow/features/auth/views/login_screen.dart';
import 'package:gymnow/features/home/views/home_screen.dart';
import 'package:gymnow/core/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => LoginViewModel()), // Provider for LoginViewModel
      ],
      child: MaterialApp(
        title: 'My App',
        theme: AppTheme.lightTheme, // Use lightTheme by default
        darkTheme: AppTheme.darkTheme, // Use darkTheme
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) =>
              const SplashScreen(), // Set SplashScreen as initial route
          '/login': (context) => const LoginScreen(), // Define login route
          '/home': (context) => const HomeScreen(), // Define home route
        },
      ),
    );
  }
}
