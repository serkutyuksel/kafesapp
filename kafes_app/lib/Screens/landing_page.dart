import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/login_page.dart';
import 'package:kafes_app/Screens/signup_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

    @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text('Kafes', style: TextStyle(color: Colors.redAccent),),
            bottom: TabBar(
              indicatorColor: Colors.redAccent,
              unselectedLabelColor: Colors.black45,
              indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              labelColor: Colors.redAccent,
              tabs: [
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
                children: [
                  LoginPage(),
                  SignUpPage(),
                ],
          ),
        ),
      );
  }
}


