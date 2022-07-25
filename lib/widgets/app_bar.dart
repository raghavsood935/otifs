import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;
    final Controller c = Get.put(Controller());
    return AppBar(
      elevation: 0,
      // title: Text(widget.title),
      flexibleSpace: Center(
        child: Row(
          children: [
            Container(
              width: wd / 2,
              height: ht / 14,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: SizedBox(
                                height: ht / 50,
                                width: 20,
                                child: Image.asset(
                                    "assets/icons/icons_png/001-pin.png")),
                          ),
                          Text(
                            c.addressType.value == "H"
                                ? "Home"
                                : c.addressType.value == "O"
                                    ? "Office"
                                    : "Custom",
                            style: const TextStyle(
                                color: Color(0xff5C5C5C),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        "${c.address["Address"]}, ${c.address["Sub_locality"]},${c.address["City"]},${c.address["State"]},${c.address["Country"]},${c.address["Postal_code"]}",
                        style: const TextStyle(
                            color: Color(0xff5C5C5C),
                            fontWeight: FontWeight.normal,
                            fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ]),
              ),
            ),
            Image.asset(
              "assets/AppBarCall.png",
              width: wd / 10,
              height: 20,
            ),
            Image.asset(
              "assets/AppBarNotification.png",
              width: wd / 10,
              height: 20,
            ),
            Image.asset(
              "assets/AppBarOffer.png",
              width: wd / 4,
            ),
          ],
        ),
      ),
    );
  }
}
