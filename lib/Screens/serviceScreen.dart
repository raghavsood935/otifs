import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stellar_track/apiCalls.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({required this.data, Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
  final data;
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: wd / 5,
            color: Colors.white,
            child: BottomNavigationBar(
                iconSize: 18,
                // elevation: ,
                backgroundColor: Colors.white,
                fixedColor: Colors.black,
                // selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black,
                selectedFontSize: 12,
                showSelectedLabels: true,
                showUnselectedLabels: true,

                // unselectedLabelStyle: TextStyle(color: Colors.black),
                // selectedLabelStyle: TextStyle(color: Colors.black),

                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Image.asset(
                      "assets/icons/BottomNav/home.png",
                      height: 24,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/call.png",
                        height: 24,
                      ),
                      label: "Book on call"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/cart.png",
                        height: 24,
                      ),
                      label: "Service cart"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/bookings.png",
                        height: 24,
                      ),
                      label: "Bookings"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/account.png",
                        height: 24,
                      ),
                      label: "Account")
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: wd / 2,
                child: Image.asset(
                  "assets/onGoingOffers.png",
                  fit: BoxFit.fill,
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Kitchen services",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Image.asset(
                      "assets/AppBarCall.png",
                      width: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Icon(Icons.bookmark),
                  ),
                ],
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return ServiceList(
                    data: widget.data,
                    index: index,
                  );
                })),
            SizedBox(
              height: wd / 3.6,
            )
          ],
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  "assets/header/kitchenIcon.png",
                  width: wd / 7,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: wd / 1.25,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            widget.data[widget.index]["product_name"],
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
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
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "This is the two line description of the service that can be customised form the backeng",
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: wd / 1.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: wd / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/time.png",
                                      width: wd / 12,
                                    ),
                                    Text(
                                      "2 hrs",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/money.png",
                                      width: wd / 12,
                                    ),
                                    Text(
                                      "${widget.data[widget.index]["price"].toString()}-${widget.data[0]["price"].toString()}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 10),
                          child: Text(
                            "BOOK",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.cyan),
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
