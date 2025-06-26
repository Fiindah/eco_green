import 'package:eco_green/login_page.dart';
import 'package:eco_green/pages/home_page.dart';
import 'package:eco_green/register_page.dart';
import 'package:eco_green/splash_page.dart';
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
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginScreenApi(),
        LoginScreenApi.id: (context) => LoginScreenApi(),
        RegisterScreenAPI.id: (context) => RegisterScreenAPI(),
        HomePage.id: (context) => HomePage(),
      },
      title: 'EcoGreen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      // home: HomePage(),
    );
  }
}
