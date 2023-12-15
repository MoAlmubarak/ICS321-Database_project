import 'package:donate_blood/pages/dore_pages/adding_d_r_page.dart';
import 'package:donate_blood/pages/homePages/home_screen.dart';
import 'package:donate_blood/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donate Blood',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginPage(),
      // home: const HomeScreen(),
      // home: const AddDRPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
