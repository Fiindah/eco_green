import 'package:eco_green/login_page.dart';
import 'package:eco_green/pages/main_wrapper_page.dart';
import 'package:eco_green/pages/profile_page.dart';
import 'package:eco_green/register_page.dart';
import 'package:eco_green/splash_page.dart';
import 'package:eco_green/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoGreen App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set SplashScreen as the initial route
      home: const SplashScreen(),
      // Define named routes
      routes: {
        SplashScreen.id:
            (context) =>
                const SplashScreen(), // Ensure SplashScreen can be a named route
        WelcomePage.id:
            (context) => const WelcomePage(), // Add WelcomePage route
        LoginScreenApi.id: (context) => const LoginScreenApi(),
        RegisterScreenAPI.id: (context) => const RegisterScreenAPI(),
        MainWrapperPage.id: (context) => const MainWrapperPage(),
        ProfilePage.id: (context) => const ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:eco_green/login_page.dart';
// import 'package:eco_green/pages/home_page.dart';
// import 'package:eco_green/register_page.dart';
// import 'package:eco_green/splash_page.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: "/",
//       routes: {
//         "/": (context) => SplashScreen(),
//         "/login": (context) => LoginScreenApi(),
//         LoginScreenApi.id: (context) => LoginScreenApi(),
//         RegisterScreenAPI.id: (context) => RegisterScreenAPI(),
//         HomePage.id: (context) => HomePage(),
//       },
//       title: 'EcoGreen',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//       ),
//       // home: HomePage(),
//     );
//   }
// }
