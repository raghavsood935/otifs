import 'package:flutter/material.dart';
import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/widgets/otpField.dart';

bool otpField = false;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          height: ht,
          color: const Color(0xff38456C),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                      height: ht / 1.7,
                      child: Image.asset(
                        "assets/housewife-woking-home-lady-blue-shirt-woman-bathroom.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Visibility(
                  visible: !otpField,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 38.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            maxLength: 10,
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
                          if (mobileController.text.length == 10) {
                            setState(() {
                              otpField = !otpField;
                            });
                            getOtp(mobileController.text.toString());
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Visibility(
                      visible: otpField,
                      child: OtpField(
                        phone: mobileController.text.toString(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: wd / 2.5,
                      child: Row(
                        children: const [
                          Text(
                            "Have Account?",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
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
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 38.0),
      child: Container(
        width: wd / 2,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent, width: 3),
            borderRadius: BorderRadius.circular(30)),
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              widget.buttonText,
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: widget.onPressed),
      ),
    );
  }
}
