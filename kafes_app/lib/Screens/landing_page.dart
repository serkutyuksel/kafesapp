import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kafes_app/Screens/login_page.dart';
import 'package:kafes_app/Screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LandingPage extends StatefulWidget {
  final _auth = FirebaseAuth.instance;
  void _createUser(
      String mail,
      String username,
      String password,
      BuildContext ctx,
      ) async {
    try {
      UserCredential Result;
      Result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);
    }
    on PlatformException catch(err) {
      var message = 'Please check your credentials!';
      if(err.message != null){
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text(message),),);
    }
  }

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
            backgroundColor: Colors.redAccent,
            title: Row(
              children: [
                Text('Kafes'),
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
                children: [
                  LoginPage(),
                  SignUpPage(widget._createUser)
                ],
          ),
        ),
      );
  }
}


