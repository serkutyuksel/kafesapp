import 'package:flutter/material.dart';

class ButtonLanding extends StatelessWidget {
  ButtonLanding ({this.buttonLabel, this.backgroundButtonColor, this.onPress});

  final String buttonLabel;
  final Function onPress;
  Color backgroundButtonColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: onPress,
        child: Text(buttonLabel),
        color: backgroundButtonColor,
        minWidth: 300.0,
      ),
    );
  }
}
