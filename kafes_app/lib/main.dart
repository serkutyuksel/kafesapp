import 'package:flutter/material.dart';
import 'Pages/welcome_page.dart';
import 'Pages/login_page.dart';
import 'Pages/signup_page.dart';
import 'Pages/home_page.dart';
import 'Pages/landing_page.dart';

void main() {
  runApp(KafesApp());
}

class KafesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: WelcomePage(),
      routes: {
        '/welcome' : (context) => WelcomePage(),
        '/login' : (context) => LoginPage(),
        '/signup' : (context) => SignUpPage(),
        '/home' : (context) => HomePage(),
        '/landing' : (context) => LandingPage(),
      },
    );
  }
}

