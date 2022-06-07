import 'dart:developer';

import 'package:flutter/material.dart';

class HomeAndPersonalService extends StatefulWidget {
  const HomeAndPersonalService(
      {required this.title, required this.color, required this.data, Key? key})
      : super(key: key);

  @override
  State<HomeAndPersonalService> createState() => _HomeAndPersonalServiceState();

  final String title;
  final Color color;
  final dynamic data;
}

class _HomeAndPersonalServiceState extends State<HomeAndPersonalService> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addToHomeServices();
  }

  addToHomeServices() async {
    log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

    for (int index = 0; index <= widget.data["data"].length; index++) {
      if (widget.data["data"][0]["name"] == "Home Services") {
        setState(() {
          homeService = widget.data["data"][0]["sub_categories"];
        });
        log(homeService.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return Container(
      color: widget.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: wd,
            height: wd / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListView.builder(
                    itemExtent: wd / 6,
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Image.network(
                            homeService[index]["banner_image"],
                            height: wd / 5,
                            width: wd / 5,
                          ),
                          Text(
                            homeService[index]["name"],
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    }))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeService {
  HomeService(
      {required this.product_id,
      required this.product_image,
      required this.product_name});

  String product_name;
  String product_image;
  String product_id;
}

// List<HomeService> homeService = [];
var homeService;
// List<Map<String, String>> homeService = [
//   {
//     "product_name": "Electric\nFaults",
//     "product_image": "assets/icons/homeService/electricFaults.png",
//     "product_id": ""
//   },
//   {
//     "Title": "Appliance\nRepair",
//     "Path": "assets/icons/homeService/applianceRepair.png"
//   },
//   {
//     "Title": "Deep\nCleaning",
//     "Path": "assets/icons/homeService/deepCleaning.png"
//   },
//   {"Title": "Masonry\nWork", "Path": "assets/icons/homeService/masonry.png"},
//   {"Title": "Plumbing\nWork", "Path": "assets/icons/homeService/plumbing.png"},
// ];
