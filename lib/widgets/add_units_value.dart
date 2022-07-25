import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/widgets/serviceButton.dart';
import 'dart:math' as math; // import this

import '../controllers.dart';

class AddUnitsValue extends StatefulWidget {
  const AddUnitsValue({required this.ht, required this.wd, Key? key})
      : super(key: key);

  final double ht;
  final double wd;
  @override
  State<AddUnitsValue> createState() => _AddUnitsValueState();
}

class _AddUnitsValueState extends State<AddUnitsValue> {
  final Controller c = Get.put(Controller());
  TextEditingController textEditingController =
      TextEditingController(text: '0');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => Dialog(
                  child: Container(
                    height: widget.ht / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Enter total square feet",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: widget.wd,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  var value =
                                      int.parse(textEditingController.text) + 1;
                                  setState(
                                    () {
                                      textEditingController.text =
                                          value.toString();
                                    },
                                  );
                                }),
                                child: Card(
                                  shape: CircleBorder(),
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/icons/icons_png/027-arrow.png",
                                        height: 12,
                                        width: 12,
                                        fit: BoxFit.cover,
                                        color: Color(0xff1FD0C2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: widget.ht / 12,
                                  width: widget.wd / 3,
                                  child: TextFormField(
                                    // initialValue: "0",
                                    textAlign: TextAlign.center,
                                    controller: textEditingController,
                                    keyboardType: TextInputType.number,
                                    // onEditingComplete: () {
                                    //   setState((() {
                                    //     c.sqft.value = textEditingController
                                    //         .text
                                    //         .toString();
                                    //   }));
                                    // },
                                  )),
                              GestureDetector(
                                onTap: (() {
                                  var value =
                                      int.parse(textEditingController.text) - 1;
                                  setState(
                                    () {
                                      textEditingController.text =
                                          value.toString();
                                    },
                                  );
                                }),
                                child: Card(
                                  shape: const CircleBorder(),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/icons/icons_png/027-arrow.png",
                                        height: 12,
                                        width: 12,
                                        fit: BoxFit.cover,
                                        color: Color(0xff1FD0C2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ServiceButton(
                          buttonText: "OK",
                          width: widget.wd / 4,
                          height: widget.ht / 20,
                          fontSize: 14,
                          onTap: () async {
                            c.sqft.value = await textEditingController.text;
                            Get.back();
                            // setState(() {
                            //   c.sqft.value =
                            //       textEditingController.text.toString();
                            // });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        width: widget.wd / 2.12,
        height: widget.ht / 15,
        color: const Color(0xffE5E5E5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Total Sq Feet",
                style: TextStyle(
                    color: Color(0xff5C5C5C),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Obx(
                () => Text(
                  c.sqft.value != '' ? c.sqft.value + ' sqft' : 'Enter Value',
                  style: const TextStyle(
                      color: Color(0xff5C5C5C),
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
              )
            ]),
      ),
    );
  }
}
