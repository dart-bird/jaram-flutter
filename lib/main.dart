import 'package:flutter/material.dart';

import 'loginPage.dart';
void main() => runApp(JaramApp());

class JaramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: JaramPage(),
    );
  }
}

Color black = Colors.black;
Color white = Colors.white;

class JaramPage extends StatefulWidget {
  @override
  _JaramPageState createState() => _JaramPageState();
}

class _JaramPageState extends State<JaramPage> {
  SizedBox buildButton(
      {String buttonTitle, Color btnTextColor, Color buttonColor, double btnTextSize, double height, double width}) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        color: buttonColor,
        child: FlatButton(
          onPressed: () {
            setState(() {});
          },
          child: Text(
            buttonTitle,
            style: TextStyle(color: btnTextColor, fontSize: btnTextSize),
          ),
        ),
      ),
    );
  }

  bool visibleText(bool boolean) {
    bool boolean = false;
    return boolean;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: LoginScreen(),
        ),
      ),
    );
  }
}