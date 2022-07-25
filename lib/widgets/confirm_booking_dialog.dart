import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/Screens/homeScreen.dart';
import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/functions.dart';
import 'package:stellar_track/main.dart';

import '../controllers.dart';
import 'serviceButton.dart';

class ConfirmBookingDialog extends StatefulWidget {
  const ConfirmBookingDialog({required this.data, Key? key}) : super(key: key);

  @override
  State<ConfirmBookingDialog> createState() => _ConfirmBookingDialogState();
  final data;
}

class _ConfirmBookingDialogState extends State<ConfirmBookingDialog> {
  final Controller c = Get.put(Controller());
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log('Booking Dialog Box' + widget.data.toString());
    var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;

    return Dialog(
      child: SizedBox(
        height: ht / 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: wd / 1.5,
                    child: const Text(
                      "Please enter your E-mail ID and contact details to confirm booking",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: wd / 2,
                // height: ,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email ID"),
                ),
              ),
              SizedBox(
                width: wd / 2,
                // height: ,
                child: TextField(
                  maxLength: 10,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: ServiceButton(
                  fontSize: 14,
                  width: wd / 2,
                  buttonText: "Confirm Booking",
                  onTap: () async {
                    log(emailController.text);
                    await savePhoneAndEmail(
                        emailController.text, phoneController.text);

                    booking(
                            c.refUserId.value,
                            "3",
                            "193",
                            widget.data["unit_name"],
                            "167",
                            "1",
                            "2022-07-12",
                            "2022-07-12",
                            "Cash",
                            c.timeSlot.value,
                            c.timeSlot.value,
                            c.mobile.value,
                            c.email.value)
                        .then((value) {
                      // log(value["response"]["type"].toString());
                      if (value["response"]["type"] == "save_success") {
                        Get.showSnackbar(const GetSnackBar(
                          message: "Service Booked",
                        ));
                        Get.offAll(const HomeScreen());
                        // Navigator.popUntil(
                        //     context,
                        //    );
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
