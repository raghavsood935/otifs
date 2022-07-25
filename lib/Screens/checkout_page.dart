import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/widgets/loader.dart';

import '../apiCalls.dart';
import '../controllers.dart';
import '../functions.dart';
import '../main.dart';
import '../widgets/serviceButton.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({required this.data, Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
  final data;
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;
    final Controller c = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: EdgeInsets.only(left: wd / 60.0),
          child: Container(
            // height: ht / 10,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Card(
                shape: CircleBorder(),
                elevation: 3,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wd / 6.0),
            child: Image.asset(
              "assets/AppBarCall.png",
              width: 20,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: ht,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: wd / 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: wd / 15),
                        child: const Text(
                          "Complete Payment",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff38456C),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: wd / 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: wd / 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹${widget.data["price"].toString()}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff38456C),
                                    fontWeight: FontWeight.normal),
                              ),
                              const Text(
                                "Per service",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff38456C),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                // "10 May, 9 AM",
                                '${c.dateSelected.value} July,${c.timeSlot.value}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff1FD0C2),
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  )
                ],
              ),
              //Referal or Coupon code ROW
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shadowColor: const Color(0xff00000029),
                  elevation: 5,
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    height: ht / 12,
                    width: wd,
                    color: const Color(0xffF7F7F7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.wallet_giftcard_outlined,
                            size: 27,
                            color: Color(0xff38456C),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Select coupon code or rewards",
                              style: TextStyle(
                                  color: Color(0xff5C5C5C), fontSize: 18),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_right)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
//Product Details
              Container(
                height: ht / 8,
                width: wd,
                color: const Color(0xffF7F7F7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      shape: const CircleBorder(),
                      elevation: 10,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        width: ht / 10,
                        child: Image.network(widget.data["product_image"]),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.data["product_name"],
                            style: const TextStyle(
                                color: Color(0xff5C5C5C),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: wd / 50),
                            child: Text(widget.data["product_summary"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xff7E7D7D), fontSize: 12)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Fill Payment Details",
                            style: TextStyle(
                                color: Color(0xff5C5C5C),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_right)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ht / 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: wd / 1.5,
                                  child: const Text(
                                    "Please enter your E-mail ID and contact details to confirm booking",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: wd / 1.5, height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15)),
                              // height: ,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    border: InputBorder.none),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: wd / 1.5,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xffE5E5E5),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15)),
                                // height: ,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  maxLength: 10,
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      hintText: "Phone no.",
                                      border: InputBorder.none,
                                      counterText: ""),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: ServiceButton(
                                fontSize: 14,
                                width: wd / 2,
                                buttonText: "Confirm Booking",
                                onTap: () async {
                                  Get.dialog(Container(child: Loader()));
                                  log(emailController.text);

                                  await savePhoneAndEmail(emailController.text,
                                      phoneController.text);

                                  await booking(
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
                                    if (value["response"]["type"] ==
                                        "save_success") {
                                      Get.back();
                                      Get.showSnackbar(const GetSnackBar(
                                        message: "Service Booked",
                                      ));
                                      Get.offAll(const HomeScreen());
                                      // Navigator.popUntil(
                                      //     context,
                                      //    );
                                    } else {
                                      Get.back();
                                      Get.dialog(
                                        Dialog(
                                            child: SizedBox(
                                                child: Text(
                                                    '${value['response']}'))),
                                      );
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
