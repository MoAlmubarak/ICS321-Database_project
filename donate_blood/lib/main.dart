import 'package:donate_blood/admin_pages/dore_pages/adding_d_r_page.dart';
import 'package:donate_blood/admin_pages/homePages/home_screen.dart';
import 'package:donate_blood/admin_pages/login_page.dart';
import 'package:donate_blood/d_r_pages/home_screen_dr.dart';
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
      // home: const LoginPage(),
      // home: const HomeScreen(),
      // home: const AddDRPage(),
      home: const HomeScreenDR(),
      debugShowCheckedModeBanner: false,
    );
  }
}
