import 'package:flutter/material.dart';
import 'package:kafes_app/Pages/login_page.dart';
import 'package:kafes_app/Pages/signup_page.dart';
import 'package:kafes_app/button_landing.dart';


class LandingPage extends StatelessWidget {

  List<Widget> containers = [
    LoginPage(),
    SignUpPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Row(
            children: [
              Text('Kafes'),
              Spacer(),
              Container(
                width: 150.0,
                child: ButtonLanding(
                  buttonLabel: 'Geç',
                  onPress: (){
                    Navigator.pushNamed(context, '/home');
                  },

                ),
              ),
            ],
          ),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Login',
            ),
            Tab(
              text: 'Sign Up',
            ),
          ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}


