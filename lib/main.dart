import 'package:flutter/material.dart';
import 'package:tugasanalisis/pages/main_page.dart';
import 'package:tugasanalisis/pages/analityc.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage(), theme: ThemeData(primarySwatch: Colors.teal),
    routes: {
        '/analytics': (context) => const AnalitycPage(), // Tambahkan rute untuk halaman analitik
      },
    );
  } 
}