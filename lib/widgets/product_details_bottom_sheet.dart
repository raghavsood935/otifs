
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/widgets/product_details_widget.dart';

import '../controllers.dart';

Future bottomSheet(context, data, slots, {bool? isCart,isBoth}) {
  final Controller c = Get.put(Controller());
  var wd = MediaQuery.of(context).size.width;
  var ht = MediaQuery.of(context).size.height;
  slots["data"].forEach((item) {});

  return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      context: context,
      builder: (context) {
        return ProductDetailsWidget(
          data: data,
          slots: slots,
          isCart: isCart,
          isBoth: isBoth
        );
      }).whenComplete(() {
    c.sqft.value = '';
    c.dateSelected.value = '';
    c.timeSlot.value = '';
    c.currentTimeSelected.value = '';
    c.currentDateSelected.value = '';
  });
}
