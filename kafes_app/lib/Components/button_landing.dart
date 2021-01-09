import 'package:flutter/material.dart';
import '../consts.dart';

class ButtonLanding extends StatelessWidget {

  final String buttonLabel;
  final Function onPress;
  final Color backgroundButtonColor, textColor;
  ButtonLanding ({
    Key key,
    this.buttonLabel,
    this.onPress, this.backgroundButtonColor = kPrimaryColor, this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: backgroundButtonColor,
          onPressed: onPress,
          child: Text(buttonLabel),
        ),
      ),
    );
  }
}
