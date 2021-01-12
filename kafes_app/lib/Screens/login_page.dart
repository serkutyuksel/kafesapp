import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Components/button_landing.dart';
import 'package:kafes_app/Screens/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _mail = '';
  var _password = '';
  UserCredential result;

  void _submit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      try {
        result = await _auth.signInWithEmailAndPassword(
            email: _mail, password: _password);
        Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(uid: result.user.uid)));
      }
      on FirebaseAuthException catch(error) {
        var warning = error.toString();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(
            warning),),);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 50.0,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.red),
                    key: ValueKey('mail'),
                    decoration: InputDecoration(labelText: 'Enter your mail'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@std.ieu.edu.tr')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _mail = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 50.0,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.red),
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Enter your password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password length must be at least 7';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonLanding(
                    buttonLabel: 'Login',
                    onPress: () {
                      _submit();
                    }
                ),
              ],
            ),
          ),
        )
    );
  }
}
