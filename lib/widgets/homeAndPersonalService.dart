import 'dart:developer';

import 'package:flutter/material.dart';

import '../models.dart';

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
  List<MainSubCategory> mainAndSubCategories = <MainSubCategory>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addToHomeServices();
  }

  addToHomeServices() async {
    log("home and Personal" + widget.data.toString());

    // for (int index = 0; index <= widget.data["data"].length; index++) {
    //   if (widget.data["data"][0]["name"] == "Home Services") {
    //     setState(() {
    //       homeService = widget.data["data"][0]["sub_categories"];
    //     });
    //     log(homeService.toString());
    //   }
    // }
    try {
      for (int i = 0; i < widget.data["data"].length; i++) {
        mainAndSubCategories.add(MainSubCategory(
            id: widget.data["data"][i]["id"].toString(),
            bannerImage: widget.data["data"][i]["banner_image"].toString(),
            mainCat: widget.data["data"][i]["main_cat"].toString(),
            name: widget.data["data"][i]["name"].toString(),
            type: widget.data["data"][i]["display_type"].toString(),
            subCategories: widget.data["data"][i]["sub_categories"]));

        for (var element in mainAndSubCategories) {
          log("NAMEEEEEEEEEEE" + element.name.toString());
        }
      }

      log(mainAndSubCategories.length.toString());
    } catch (e) {
      log("ooops" + e.toString());
    }
    // setState(() {
    //   mainAndSubCategories = value;
    // });

    log("This is inportant =======================> ${mainAndSubCategories.length.toString()}");
  }

  // categorizer() async {
  //   var service;
  //   for (int i = 0; i < mainAndSubCategories.length; i++) {
  //     mainAndSubCategories.forEach((element) {
  //       if (element.name == '') {}
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return SizedBox(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: mainAndSubCategories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            print("data verification  ${mainAndSubCategories[index].name}");
            return mainAndSubCategories[index].type == "grid"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              mainAndSubCategories[index].name,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: wd,
                            // height: wd / 1.2,
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: mainAndSubCategories[index]
                                    .subCategories
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        // mainAxisExtent: wd / 1.8,
                                        // crossAxisSpacing: 0,
                                        // mainAxisSpacing: 0,
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int count) {
                                  return SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          child: SizedBox(
                                            height: wd / 2.5,
                                            width: wd / 2.5,
                                            child: Image.network(
                                              mainAndSubCategories[index]
                                                      .subCategories[count]
                                                  ["banner_image"],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          mainAndSubCategories[index]
                                              .subCategories[count]["name"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                : mainAndSubCategories[index].type == "list"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          color: widget.color,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 10),
                                child: Text(
                                  mainAndSubCategories[index].name,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: wd,
                                height: wd / 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        // itemExtent: wd / 4,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: mainAndSubCategories[index]
                                            .subCategories
                                            .length,
                                        shrinkWrap: true,
                                        itemBuilder: ((context, count) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0, vertical: 18),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  mainAndSubCategories[index]
                                                          .subCategories[count]
                                                      ["banner_image"],
                                                  height: wd / 7,
                                                  width: wd / 7,
                                                ),
                                                Text(
                                                  mainAndSubCategories[index]
                                                          .subCategories[count]
                                                      ["name"],
                                                  style: const TextStyle(
                                                      color: Color(0xff5C5C5C)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          );
                                        }))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container();
          }),
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
