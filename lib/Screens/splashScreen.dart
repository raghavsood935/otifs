import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:stellar_track/Screens/homeScreen.dart';
import 'package:stellar_track/Screens/signInScreen.dart';
import 'package:stellar_track/Screens/signup_screen.dart';
import 'package:stellar_track/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    return AnimatedSplashScreen(
        backgroundColor: Color(0xff38456C),
        duration: 2500,
        splash: SizedBox(
          height: ht,
          width: wd,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Logo(ht: ht)),
        ),
        nextScreen: const SignUpScreen());
  }
}
