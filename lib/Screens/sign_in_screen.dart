import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/Screens/Main%20Screens/home_page.dart';
import 'package:stellar_track/Screens/add_address_screen.dart';
import 'package:stellar_track/Screens/signup_screen.dart';
import 'package:stellar_track/api_calls.dart';
import 'package:stellar_track/controllers.dart';
import 'package:stellar_track/functions.dart';

import '../main.dart';
import '../widgets/shimmer_loader.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Controller c = Get.find();
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: ht,
            color: const Color(0xff38456C),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                      height: ht / 3,
                      child: Image.asset(
                        "assets/popularServices/bathroomDC.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 38.0),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        controller: mobileController,
                        cursorColor: const Color(0xff38456C),
                        decoration: const InputDecoration(
                            hintText: "Enter Mobile Number / Email id",
                            counterText: "",
                            border: InputBorder.none,
                            iconColor: Colors.white,
                            focusColor: Colors.white,
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 38.0),
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          maxLength: 15,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          cursorColor: const Color(0xff38456C),
                          decoration: const InputDecoration(
                              hintText: "Enter Password",
                              counterText: "",
                              border: InputBorder.none,
                              iconColor: Colors.white,
                              focusColor: Colors.white,
                              fillColor: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40, horizontal: 38.0),
                  child: Container(
                    width: wd / 2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.greenAccent, width: 3),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (mobileController.text.isEmpty) {
                          Get.showSnackbar(const GetSnackBar(
                            duration: Duration(seconds: 2),
                            message: "Email can't be empty",
                          ));
                        } else if (passwordController.text.isEmpty) {
                          Get.showSnackbar(const GetSnackBar(
                            duration: Duration(seconds: 2),
                            message: "Password can't be empty",
                          ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor:
                                      Colors.transparent.withOpacity(0.5),
                                  child: const LocationShimmer(
                                      height: 30,
                                      width: 100,
                                      string: "Validating"),
                                );
                              });
                          loginwithPassword(mobileController.text.toString(),
                                  passwordController.text.toString())
                              .then((value) async {
                            setState(() {
                              c.refUserId.value = value["data"]["ref_user_id"];
                            });
                            await saveLoginStatus(value["data"]["ref_user_id"])
                                .then((value) {
                              setState(() {});
                            });
                            // if (value["response"]["message"].toString() ==
                            //     "Logged in succesfully") {
                            //   if (widget.onboarding == false) {
                            //     await saveLoginStatus(value["data"]["ref_user_id"])
                            //         .then((value) => print("Ref ID Saved"));
                            //   } else {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => const AddAddress()));
                            //   }
                            // }
                            value["response"]["message"].toString() ==
                                    "Logged in successfully"
                                ? Get.close(1)
                                : listUserAddresses(c.refUserId.value, null)
                                    .then((value) {
                                    if (value['response']['message'] ==
                                        "Data not available") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddAddress()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                    }
                                  });
                          }).then((value) async {
                            await getCartCount(c.refUserId.value).then(
                              (value) {
                                setState(() {
                                  c.cartCount.value =
                                      value['data'][0]['car_count'];
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                });
                              },
                            );
                          });
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "Login with OTP",
                            style: TextStyle(
                                color: Color(0xff1FD0C2), fontSize: 16),
                          ),
                        ),
                      ),
                    ),
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
                                    builder: (context) => const HomeScreen()));
                          },
                          child: const Text(
                            "SKIP",
                            style: TextStyle(
                                color: Color(0xff1FD0C2), fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
