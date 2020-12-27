import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafes_app/button_landing.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage(this.submitForm);
  final void Function(
      String mail,
      String username,
      String password,
      String department,
      BuildContext cnt,
      )submitForm;
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  var _mail = '';
  var _username = '';
  var _password = '';
  var _department = '';

  void _submit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState.save();
      widget.submitForm(
        _mail.trim(),
        _username.trim(),
        _password.trim(),
        _department.trim(),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  key: ValueKey('username'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 3) {
                      return 'Username length must be at least 3';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _username = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter your username'
                  ),
                ),
              ),),
              Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  key: ValueKey('department'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 3) {
                      return 'Department length must be at least 3';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _department = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter your department'
                  ),
                ),
              ),),
              Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0,),
                child: TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if(value.isEmpty || value.length < 7) {
                      return 'Password length must be at least 7';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                  ),
                  obscureText: true,
                ),
              ),),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,),
                  child: TextFormField(
                    key: ValueKey('email'),
                    validator: (value){
                      if(value.isEmpty || !value.contains('@ieu.edu.tr')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter your university mail'
                    ),
                    onSaved: (value) {
                      _mail = value;
                    },
                  ),
                ),),
              Expanded(child: ButtonLanding(
                buttonLabel: 'Sign Up',
                backgroundButtonColor: Colors.white,
                onPress: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
