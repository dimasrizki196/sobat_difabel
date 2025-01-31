import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class DashboardScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  DashboardScreen({super.key});
  // Method to handle logout
  void _logout(BuildContext context) async {
    await _authService.logoutUser();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Dashboard'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
