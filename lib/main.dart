import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; 
import 'screens/register_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/notFound_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sobat Difable',
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/register':
            return MaterialPageRoute(builder: (_) => RegisterScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/dashboard':
            return MaterialPageRoute(builder: (_) => DashboardScreen());
          // Tambahkan kasus untuk route lainnya
          default:
            return MaterialPageRoute(builder: (_) => NotFoundScreen());
        }
      },
    );
  }
}


