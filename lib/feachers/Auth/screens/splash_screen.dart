import 'dart:async';

import 'package:DISH_DELIGhTS/feachers/main/main_page/screens/first_page.dart';
import 'package:DISH_DELIGhTS/feachers/Auth/screens/stepper_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import 'Sign_up.dart';

class SplashScreen extends StatefulWidget {
  final bool isgetStart;
  final bool  islogin;
  const SplashScreen({super.key,required this.isgetStart,required this.islogin});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    // for (int i = 0; i < 4; i++) {

    Timer(Duration(milliseconds: 250), () {
      setState(() {
        opacity = 1;
      });
    });

    Timer(Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>! widget.isgetStart
            ? StepperScreen()
            : widget.islogin
                ? FirstPage()
                : SignUp(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      body: Center(
          child: AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 750),
        child: Image(
          image: AssetImage('assest/logo.png'),
        ),
      )),
    );
  }
}
