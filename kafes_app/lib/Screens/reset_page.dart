import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/Components/button_landing.dart';
import 'package:kafes_app/Screens/landing_page.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var _mail = '';

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success!", style: TextStyle(color: Colors.redAccent),),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("We have sent a link to your email address:"),
                  Text("$_mail"),
                  Text("Please follow the instructions to reset your password"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text("OK", style: TextStyle(color: Colors.redAccent),),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LandingPage()));
                  }
              ),
            ],
          );
        }
    );
  }
  void _submit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      try {
        await _auth.sendPasswordResetEmail(email: _mail);
        _showDialog();
      }
      on FirebaseAuthException catch (error) {
        var warning = error.toString();
        final snackBar = SnackBar(content: Text(warning));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Reset Password", style: TextStyle(color: Colors.redAccent),),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey("email"),
                  decoration: InputDecoration(labelText: "Email"),
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
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text("Return Login page",
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LandingPage()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ButtonLanding(
                buttonLabel: "Send Password Reset Mail",
                onPress: () {
                  _submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
