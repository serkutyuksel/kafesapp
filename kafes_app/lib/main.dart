import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens//login_page.dart';
import 'Screens//signup_page.dart';
import 'Screens//home_page.dart';
import 'Screens//landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(KafesApp());
}

class KafesApp extends StatelessWidget {
  void Function(String mail, String username, String password,
      String department, BuildContext cnt) get createUser => null;

  void Function(String mail, String password,
      BuildContext cnt) get signInUser => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
      routes: {
        '/login' : (context) => LoginPage(signInUser),
        '/signup' : (context) => SignUpPage(createUser),
        '/home' : (context) => HomePage(),
        '/landing' : (context) => LandingPage(),
      },
    );
  }
}

