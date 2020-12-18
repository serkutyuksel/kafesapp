import 'package:flutter/material.dart';
import 'package:kafes_app/button_landing.dart';



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter your username'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter your password'),
              ),
            ),
          ),
          Expanded(
            child: ButtonLanding(
              buttonLabel: 'Login',
              backgroundButtonColor: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
