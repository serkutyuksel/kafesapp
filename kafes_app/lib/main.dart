import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/new_post.dart';
import 'package:kafes_app/Screens/profile_page.dart';
import 'Screens//login_page.dart';
import 'Screens//signup_page.dart';
import 'Screens//home_page.dart';
import 'Screens//landing_page.dart';
import 'Screens/new_post.dart';
import 'Screens/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(KafesApp());
}

class KafesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        '/login' : (context) => LoginPage(),
        '/signup' : (context) => SignUpPage(),
        '/home' : (context) => HomePage(),
        '/landing' : (context) => LandingPage(),
        '/add_post' : (context) => NewPost(),
        '/profile' : (context) => ProfilePage(),
      },
    );
  }
}

