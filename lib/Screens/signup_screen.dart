import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/controllers.dart';
import 'package:stellar_track/main.dart';
import 'package:stellar_track/widgets/mobile_field.dart';
import 'package:stellar_track/widgets/otpField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool verifyingOtp = false;
    final Controller c = Get.put(Controller());
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Obx(
          () => Container(
            height: ht,
            color: const Color(0xff38456C),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: ht / 1.8,
                        child: Image.asset(
                          "assets/housewife-woking-home-lady-blue-shirt-woman-bathroom.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ht / 60),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Visibility(visible: !c.otpField.value, child: MObileField()),
                  Padding(
                    padding: EdgeInsets.all(ht / 50),
                    child: Visibility(
                        visible: c.otpField.value,
                        child: OtpField(
                          phone: c.mobile.value,
                        )),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: ht / 50),
                  //   child: Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: SizedBox(
                  //       width: wd / 2.5,
                  //       child: Row(
                  //         children: const [
                  //           Text(
                  //             "Have Account?",
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 14),
                  //           ),
                  //           Text(
                  //             "Sign In",
                  //             style: TextStyle(
                  //                 color: Color(0xff1FD0C2), fontSize: 15),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: wd / 15,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: const Text(
                          "SKIP",
                          style:
                              TextStyle(color: Color(0xff1FD0C2), fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpFlowButton extends StatefulWidget {
  SignUpFlowButton(
      {required this.buttonText, required this.onPressed, Key? key})
      : super(key: key);

  @override
  State<SignUpFlowButton> createState() => _SignUpFlowButtonState();

  final String buttonText;
  var onPressed;
}

class _SignUpFlowButtonState extends State<SignUpFlowButton> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 38.0),
      child: Container(
        width: wd / 2,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff1FD0C2), width: 3),
            borderRadius: BorderRadius.circular(30)),
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              widget.buttonText,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: widget.onPressed),
      ),
    );
  }
}
