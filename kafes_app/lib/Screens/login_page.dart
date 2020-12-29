import 'package:flutter/material.dart';
import 'package:kafes_app/button_landing.dart';



class LoginPage extends StatefulWidget {
  LoginPage(this.submitForm);
  final void Function(
      String mail,
      String password,
      BuildContext cnt,
      )submitForm;
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  var _mail = '';
  var _password = '';

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState.save();
      widget.submitForm(
        _mail.trim(),
        _password.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Form(
          key: _formKey,
          child:Column (
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('mail'),
                  decoration: InputDecoration(labelText: 'Enter your mail'),
                  validator: (value){
                    if(value.isEmpty || !value.contains('@ieu.edu.tr')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _mail = value;
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.red),
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: 'Enter your password'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 7) {
                      return 'Password length must be at least 7';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _password = value;
                  },
                  obscureText: true,
                ),
              ),
            ),
            Expanded(
              child: ButtonLanding(
                buttonLabel: 'Login',
                backgroundButtonColor: Colors.white,
                onPress: _submit,
              ),
            ),
          ],
        ),
      )
      )
    );
  }
  }

