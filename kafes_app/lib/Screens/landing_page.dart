import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kafes_app/Screens/login_page.dart';
import 'package:kafes_app/Screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingPage extends StatefulWidget {
  final _auth = FirebaseAuth.instance;
  void _createUser(
      String mail,
      String username,
      String password,
      String department,
      BuildContext cnt,
      ) async {
    try {
      UserCredential Result;
      Result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);
      FirebaseFirestore.instance.collection('user').doc(Result.user.uid)
      .set({
        'username': username,
        'email': mail,
        'department': department,
      });
    }
    on PlatformException catch(error) {
      var message = 'An Error Occurred!';
      if(error.message != null){
        message = error.message;
      }
      Scaffold.of(cnt).showSnackBar(SnackBar(content:Text(message),),);
    }
  }
  void _signInUser(
      String mail,
      String password,
      BuildContext cnt,
      ) async {
    try {
    UserCredential Result;
    Result = await _auth.signInWithEmailAndPassword(email: mail, password: password);
  }
  on PlatformException catch(error){
      var message = 'An Error Occured!';
      if(error.message != null) {
        message = error.message;
      }
      Scaffold.of(cnt).showSnackBar(SnackBar(content: Text(message),),);
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
                  LoginPage(widget._signInUser),
                  SignUpPage(widget._createUser),
                ],
          ),
        ),
      );
  }
}


