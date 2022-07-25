import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/widgets/bottomNav.dart';
import 'package:stellar_track/widgets/loader.dart';
import 'package:stellar_track/widgets/shimmerLoader.dart';

import '../widgets/product_details_bottom_sheet.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen(
      {required this.mainCatID,
      required this.subCatID,
      required this.mainCatImage,
      Key? key})
      : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();

  final mainCatID;
  final subCatID;
  final mainCatImage;
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices(widget.mainCatID, widget.subCatID).then((value) {
      setState(() {
        servicesData = value;
      });
    });
  }

  var servicesData;
  @override
  Widget build(BuildContext context) {
    print("This is Service Data" + servicesData.toString());
    log(widget.mainCatID.toString());
    log(widget.subCatID.toString());
    var wd = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            SizedBox(height: wd / 4.8, child: BottomNavigation()),
        // resizeToAvoidBottomInset: false,
        // floatingActionButton: BottomNavigation(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 40,
          leading: Container(
            height: 5,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: servicesData == null
            ? Center(
                child: ShimmerLoader(
                width: wd,
                height: 50,
              ))
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: wd / 2,
                        width: wd,
                        child: Image.network(
                          widget.mainCatImage,
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              servicesData["data"][0]["category_name"]
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Icon(
                              Icons.bookmark,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: servicesData["data"].length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return ServiceList(
                            data: servicesData,
                            index: index,
                          );
                        })),
                    SizedBox(
                      height: wd / 3.6,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class ServiceList extends StatefulWidget {
  ServiceList({required this.data, required this.index, Key? key})
      : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
  var data;
  int index;
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return widget.data == null
        ? Center(child: ShimmerLoader(height: 50, width: wd))
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.data["data"][widget.index]["product_image"] == "")
                    Container(
                      width: wd / 7,
                    )
                  else
                    Container(
                        width: wd / 7,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: widget.data["data"][widget.index]
                                    ["product_image"] ==
                                null
                            ? Container()
                            : Image.network(
                                widget.data["data"][widget.index]
                                    ["product_image"],
                                fit: BoxFit.fill,
                                // width: wd / 7,
                              )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: wd / 1.25,
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SizedBox(
                                  width: wd / 1.8,
                                  child: Text(
                                    // "",
                                    widget.data["data"][widget.index]
                                        ["product_name"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.0),
                                child: Text(
                                  "ADD",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: wd / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.data["data"][widget.index]
                                      ['product_summary']
                                  .toString(),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wd / 1.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: wd / 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/time.png",
                                            width: wd / 12,
                                          ),
                                          Text(
                                            widget.data["data"][widget.index]
                                                ["service_time"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff38456C),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/money.png",
                                            width: wd / 12,
                                          ),
                                          Text(
                                            "₹${widget.data["data"][widget.index]["price"].toString()}-₹${widget.data["data"][widget.index]["sell_price"].toString()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff38456C),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 0.0, left: 0),
                                child: GestureDetector(
                                  onTap: (() async {
                                    var slots;
                                    var value;
                                    await getProductDetails(widget.data["data"]
                                            [widget.index]["product_id"])
                                        .then(
                                      (item) {
                                        setState(() {
                                          value = item;
                                        });
                                      },
                                    );
                                    await getTimeSlots(widget.data["data"]
                                            [widget.index]["product_id"])
                                        .then((value) {
                                      setState(() {
                                        slots = value;
                                      });
                                    });
                                    bottomSheet(
                                        context, value["data"][0], slots);
                                  }),
                                  child: const Text(
                                    "BOOK",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.cyan),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
              )
            ],
          );
  }
}
