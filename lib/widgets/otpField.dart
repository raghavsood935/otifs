import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:stellar_track/Screens/add_address_screen.dart';
import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/controllers.dart';
import 'package:stellar_track/widgets/shimmerLoader.dart';

import 'signup_flow_button.dart';

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
    final Controller c = Get.find();

    var wd = MediaQuery.of(context).size.width;
    return SizedBox(
      width: wd / 1.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OTPTextField(
            width: wd / 2,
            length: 4,
            fieldWidth: wd / 10,
            controller: controller,
            fieldStyle: FieldStyle.box,
            spaceBetween: wd / 30,
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
                  c.otpField.value = !c.otpField.value;
                });
              },
              child: const Text(
                "Change Mobile number?",
                style: TextStyle(color: Colors.white),
              )),
          SignUpFlowButton(
              buttonText: "Confirm OTP",
              onPressed: () async {
                print("Entered OTP" + otp);
                // bool verifyingOtp = true;
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent.withOpacity(0.5),
                        child: const LocationShimmer(
                            height: 30, width: 100, string: "Validating"),
                      );
                    });
                validateOTP(c.mobile.value, otp).then((value) {
                  log(value["response"]["message"].toString());
                  Get.back();
                  value["response"]["message"].toString() ==
                          "Logged in successfully"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddAddress()))
                      : null;
                });
              }),
        ],
      ),
    );
  }
}
