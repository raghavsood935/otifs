import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/signup_screen.dart';
import '../apiCalls.dart';
import '../controllers.dart';

class MObileField extends StatefulWidget {
  const MObileField({Key? key}) : super(key: key);

  @override
  State<MObileField> createState() => _MObileFieldState();
}

class _MObileFieldState extends State<MObileField> {
  final Controller c = Get.find();
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ht / 50, horizontal: ht / 60),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              controller: mobileController,
              cursorColor: const Color(0xff38456C),
              decoration: const InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  iconColor: Colors.white,
                  focusColor: Colors.white,
                  fillColor: Colors.white),
            ),
          ),
        ),
        SignUpFlowButton(
          buttonText: "Proceed for OTP",
          onPressed: () {
            log("pressed");
            log(mobileController.text.toString());
            if (mobileController.text.length == 10) {
              print("Success");
              setState(() {
                c.otpField.value = !c.otpField.value;
                c.mobile.value = mobileController.text.toString();
              });
              getOtp(mobileController.text.toString()).then((value) {
                Get.showSnackbar(GetSnackBar(
                  message: value["data"]["otp"].toString(),
                ));

                // showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //           title: Text(value["data"]["otp"].toString()),
                //         ));
              });
            }
          },
        ),
      ],
    );
  }
}
