import 'package:flutter/material.dart';
import 'package:gymnow/features/home/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:gymnow/features/auth/providers/auth_provider.dart';
import 'package:gymnow/features/auth/viewmodels/login_viewmodel.dart';
import 'package:gymnow/core/utils/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final theme = AppTheme.lightTheme; // Access the AppTheme

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: theme.primaryColor), // Use the primary color
                ),
              ),
              onChanged: (value) => loginViewModel.setEmail(value),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: theme.primaryColor), // Use the primary color
                ),
              ),
              onChanged: (value) => loginViewModel.setPassword(value),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: authProvider.isLoading
                  ? null
                  : () async {
                      try {
                        await authProvider.login(
                          loginViewModel.email,
                          loginViewModel.password,
                        );

                        if (authProvider.user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomeScreen()), // Navigate to HomeScreen
                          );
                        } else if (authProvider.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(authProvider.errorMessage!),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('An unexpected error occurred.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor, // Customize button color
                foregroundColor: Colors.white,
              ),
              child: authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
