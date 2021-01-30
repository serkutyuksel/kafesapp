import 'package:flutter/material.dart';
import 'package:kafes_app/Components/button_landing.dart';
import 'package:kafes_app/Screens/landing_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              color: Colors.redAccent,
              size: 60.0,
              semanticLabel: "Email Verification",
            ),
            Text(
                "Welcome to Kafes! Please Verify Your Email Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.redAccent,
                ),
            ),
            ButtonLanding(
              buttonLabel: "OK",
              onPress: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LandingPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
