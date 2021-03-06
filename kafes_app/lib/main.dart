import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/new_post.dart';
import 'package:kafes_app/Screens/post_page.dart';
import 'package:kafes_app/Screens/profile_page.dart';
import 'package:kafes_app/Screens/welcome_page.dart';
import 'package:kafes_app/Screens/reset_page.dart';
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
      home: AuthenticationListener(),
      routes: {
        '/login' : (context) => LoginPage(),
        '/signup' : (context) => SignUpPage(),
        '/home' : (context) => HomePage(),
        '/landing' : (context) => LandingPage(),
        '/add_post' : (context) => NewPost(),
        '/profile' : (context) => ProfilePage(),
        '/post_page' : (context) => PostPage(),
        '/welcome_page': (context) => WelcomePage(),
        '/reset_page': (context) => ResetPage(),
      },
    );
  }
}

class AuthenticationListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      return HomePage(uid: user.uid);
    }
    else {
      return LandingPage();
    }
  }
}

