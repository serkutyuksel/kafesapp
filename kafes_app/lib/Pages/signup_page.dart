import 'package:flutter/material.dart';
import '../button_landing.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [

          Expanded(child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0,),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your Name'
              ),
            ),
          ),),
          Expanded(child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0,),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your username'
              ),
            ),
          ),),
          Expanded(child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0,),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your password'
              ),
            ),
          ),),
          Expanded(child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0,),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your mail'
              ),
            ),
          ),),
          Expanded(child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0,),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your Department'
              ),
            ),
          ),),
          Expanded(child: ButtonLanding(
            buttonLabel: 'Sign Up',
            backgroundButtonColor: Colors.white,
          ),),
          Expanded(child: ButtonLanding(
            buttonLabel: 'Sign Up with Instagram',
            backgroundButtonColor: Colors.white,
          ),),

        ],
      ),
    );
  }
}


