import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/bg_splash.png'),
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
