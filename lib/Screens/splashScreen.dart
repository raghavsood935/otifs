import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:stellar_track/Screens/homeScreen.dart';
import 'package:stellar_track/Screens/signInScreen.dart';
import 'package:stellar_track/Screens/signUpScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    return AnimatedSplashScreen(
        backgroundColor: Colors.blue,
        duration: 2500,
        splash: SizedBox(
          height: ht,
          width: wd,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: ht / 4,
                  width: ht / 8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "OTIFS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue),
                    ),
                  ),
                ),
                Container(
                  child: Text("Happy to Serve,\nAlways",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white)),
                )
              ],
            ),
          ),
        ),
        nextScreen: SignUpScreen());
  }
}
