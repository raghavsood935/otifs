import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/widgets/add_units_value.dart';
import 'package:stellar_track/widgets/confirm_booking_dialog.dart';
import 'package:stellar_track/widgets/day_slots.dart';
import 'package:stellar_track/widgets/serviceButton.dart';
import 'package:stellar_track/widgets/time_slots.dart';

import '../Screens/checkout_page.dart';
import '../controllers.dart';
import 'date_slot_selection.dart';
import 'time_slot_selection.dart';

bottomSheet(context, data, slots) {
  final Controller c = Get.put(Controller());
  var wd = MediaQuery.of(context).size.width;
  var ht = MediaQuery.of(context).size.height;
  slots["data"].forEach((item) {
    log(item["start"]);
  });

  return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      context: context,
      builder: (context) {
        log(data.toString());

        return StatefulBuilder(
            builder: ((context, setState) => SizedBox(
                  height: ht / 1.2,
                  width: wd,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  // height: 30,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                        elevation:
                                            MaterialStateProperty.all(5)),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Image.asset(
                              "assets/AppBarCall.png",
                              width: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Icon(
                              Icons.bookmark,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ht / 2.25,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Card(
                                    shape: const CircleBorder(),
                                    elevation: 10,
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      width: ht / 7,
                                      child:
                                          Image.network(data["product_image"]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data["product_name"],
                                              style: const TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: wd / 50),
                                              child: Text(
                                                  data["product_summary"],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Color(0xff7E7D7D),
                                                      fontSize: 12)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: wd / 50),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: wd / 1.75,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/time.png",
                                                                width: wd / 12,
                                                              ),
                                                              Text(
                                                                data[
                                                                    "service_time"],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xff38456C),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      wd / 80),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/money.png",
                                                                width: wd / 10,
                                                              ),
                                                              Text(
                                                                "₹${data["price"].toString()}-₹${data["sell_price"].toString()}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xff38456C),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: wd / 50),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Text(
                                                        "3400",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xff38456C),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 2.0),
                                                        child: Text(
                                                          "bookings",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff7E7D7D),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    "assets/RatingImage.jpeg",
                                                    height: ht / 20,
                                                    width: wd / 3.5,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: wd / 5,
                              width: wd / 1.2,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data["images"].length,
                                  shrinkWrap: true,
                                  itemExtent: wd / 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          height: wd / 5,
                                          width: wd / 5,
                                          color: Colors.black12,
                                          child: data["images"][index]
                                                      ["product_image"] !=
                                                  null
                                              ? Image.network(
                                                  data["images"][index]
                                                      ["product_image"],
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              child: SizedBox(
                                width: wd,
                                child: Text(data["product_summary"],
                                    // maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Color(0xff7E7D7D),
                                        fontSize: 12)),
                              ),
                            ),
                          ],
                        )),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 12.0,
                                  ),
                                ],
                              ),
                              child: Card(
                                elevation: 20,
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.all(0),
                                child: Container(
                                  width: wd,
                                  color: const Color(0xffF7F7F7),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Select Date and time slot",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff5C5C5C)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: wd / 2.12,
                                                height: ht / 14,
                                                color: const Color(0xffE5E5E5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 0),
                                                              child: SizedBox(
                                                                  height:
                                                                      ht / 50,
                                                                  width: 20,
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/icons/icons_png/001-pin.png")),
                                                            ),
                                                            Text(
                                                              c.addressType
                                                                          .value ==
                                                                      "H"
                                                                  ? "Home"
                                                                  : c.addressType
                                                                              .value ==
                                                                          "O"
                                                                      ? "Office"
                                                                      : "Custom",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff5C5C5C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "${c.address["Address"]}, ${c.address["Sub_locality"]},${c.address["City"]},${c.address["State"]},${c.address["Country"]},${c.address["Postal_code"]}",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xff5C5C5C),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 10),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              // Enter unit Values Widget
                                              AddUnitsValue(ht: ht, wd: wd)
                                            ],
                                          ),
                                        ),
                                        const DateSlotSelection(),
                                        TimeSlotsSelection(slots: slots),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ServiceButton(
                                              onTap: () {
                                                Get.to(CheckoutPage(
                                                  data: data,
                                                ));
                                                // showDialog(
                                                //     context: context,
                                                //     builder: (context) {
                                                //       return ConfirmBookingDialog(
                                                //         data: data,
                                                //       );
                                                //     });
                                              },
                                              width: wd / 1.8,
                                              color: const Color(0xff38456C),
                                              fontSize: 16,
                                              buttonText:
                                                  "Book one time service"),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                )));
      }).whenComplete(() {
    c.sqft.value = '';
    c.dateSelected.value = '';
    c.timeSlot.value = '';
    c.currentTimeSelected.value = '';
    c.currentDateSelected.value = '';
  });
}
