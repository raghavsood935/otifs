import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/models.dart';

import '../controllers.dart';
import 'day_slots.dart';

class DateSlotSelection extends StatefulWidget {
  const DateSlotSelection({Key? key}) : super(key: key);

  @override
  State<DateSlotSelection> createState() => _DateSlotSelectionState();
}

class _DateSlotSelectionState extends State<DateSlotSelection> {
  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 3,
          // itemExtent: 40,
          itemBuilder: (context, index) {
            log(c.weekday.value);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(
                () => GestureDetector(
                    onTap: (() {
                      c.currentDateSelected.value = index.toString();
                      c.dateSelected.value =
                          "${int.parse(c.date.value.toString().split('-').last) + index}";
                      // print(index);
                    }),
                    child: DaySlots(
                      weekday: (int.parse(c.weekday.value) + index <= 6)
                          ? "${int.parse(c.weekday.value) + index}"
                          : (index - 1).toString(),
                      date:
                          "${int.parse(c.date.value.toString().split('-').last) + index}",
                      selected: c.currentDateSelected.value == index.toString()
                          ? true
                          : false,
                    )),
              ),
            );
          }),
    );
  }
}
