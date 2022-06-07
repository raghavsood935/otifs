import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:stellar_track/Screens/homeScreen.dart';
import 'package:stellar_track/apiCalls.dart';

import '../Screens/signUpScreen.dart';

class OtpField extends StatefulWidget {
  OtpField({required this.phone, Key? key}) : super(key: key);
  String phone;
  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  String otp = "";
  OtpFieldController controller = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return SizedBox(
      width: wd / 1.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OTPTextField(
            width: wd / 2,
            length: 4,
            fieldWidth: 40,
            controller: controller,
            fieldStyle: FieldStyle.box,
            spaceBetween: 10,
            onChanged: (value) {
              print("Changed" + value);
            },
            onCompleted: (value) {
              print("on Complete" + value);
              setState(() {
                otp = value.toString();
              });
              print("Final OTP" + otp);

              // validateOTP(widget.phone, value.toString());
              // value == "1111"
              //     ? Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => HomePage()))
              //     : log("OTP INCORRECT");
            },
            otpFieldStyle: OtpFieldStyle(
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                enabledBorderColor: Colors.white,
                focusBorderColor: Colors.white),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  otpField = !otpField;
                });
              },
              child: Text(
                "Change Mobile number?",
                style: TextStyle(color: Colors.white),
              )),
          SignUpFlowButton(
              buttonText: "Confirm OTP",
              onPressed: () {
                print("Entered OTP" + otp);
                validateOTP(widget.phone, otp).then((value) {
                  log(value["response"]["message"].toString());
                  value["response"]["message"].toString() ==
                          "Logged in successfully"
                      ? Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()))
                      : null;
                });
              }),
        ],
      ),
    );
  }
}
