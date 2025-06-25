import 'package:flutter/material.dart';
import 'package:tugasanalisis/pages/main_page.dart';
import 'package:tugasanalisis/pages/analityc.dart';
import 'package:tugasanalisis/pages/login_page.dart';
import 'package:tugasanalisis/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const MainPage(),
        '/analytics': (context) => const AnalitycPage(),
      },
    );
  }
}
