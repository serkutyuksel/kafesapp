import 'package:flutter/material.dart';
import '../button_landing.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
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
          Expanded(child: Text('Forgot Password',),),
          Expanded(
            child: ButtonLanding(
              buttonLabel: 'Login',
              backgroundButtonColor: Colors.white,
            ),
          ),
          Expanded(
            child: ButtonLanding(
              buttonLabel: 'Login with Instagram',
              backgroundButtonColor: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
