import 'package:flutter/material.dart';
import 'package:kafes_app/button_landing.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Image(
              image: AssetImage('assets/images/monkey.png'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Text('Ortak paydada buluştuğun öğrencilerle birlikte yeni bir yolculuğa hazır mısın?',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ),
        Expanded(
          child: ButtonLanding(
            buttonLabel: 'Let\'s Start',
            onPress: () {
              Navigator.pushNamed(context, '/landing');
            },
          ),
        ),

      ],
    );
  }
}
