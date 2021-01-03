import 'package:flutter/material.dart';
import 'package:kafes_app/button_landing.dart';
import 'package:kafes_app/Screens/profile_page.dart' ;




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
      body: Form(
        key: _formKey,
        child:Column (
        children: [
          Container(
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
          Container(
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
          ButtonLanding(
            buttonLabel: 'Login',
            onPress: () {
              _submit();
              //_submit method birşeyler return etmeli, bunu check edip o şekilde profil sayfasına yönlendirmeliyiz.
              // profil sayfasına, kişinin UID'si veya username'i paslanıp, profil sayfasından gerekli bilgiler çekilmeli.
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
              }
          ),
        ],
      ),
      )
    );
  }
  }



// onPress: () { _submit;
//Navigator.pushReplacement(
//context,MaterialPageRoute(builder: (context) => ProfilePage()),);}
