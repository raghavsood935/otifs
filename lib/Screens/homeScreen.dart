import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/functions.dart';
import 'package:stellar_track/widgets/app_bar.dart';
import 'package:stellar_track/widgets/carousel.dart';
import 'package:stellar_track/widgets/homeAndPersonalService.dart';
import 'package:stellar_track/widgets/home_top_banner.dart';
import 'package:stellar_track/widgets/loader.dart';
import 'package:stellar_track/widgets/mainCategoriesList.dart';
import 'package:stellar_track/widgets/popularServices.dart';
import 'package:stellar_track/widgets/serviceButton.dart';
import 'package:stellar_track/widgets/shimmerLoader.dart';

import '../apiCalls.dart';
import '../controllers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller c = Get.put(Controller());
  var data;
  var mainAndSubCategories;
  var popularServices;
  var banners;
  var summerSpecial;
  var onGoingOffers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try {
      determinePosition().then(
        (value) {
          log("Current Position ====>  ${value.toString()}");
        },
      );
    } catch (e) {
      log(e.toString());
    }

    getSeasonalOffers().then((value) {
      setState(() {
        summerSpecial = value;
      });
    });

    getOngoingOffers().then((value) {
      setState(() {
        onGoingOffers = value;
      });
    });

    getHomeBanners().then(((value) {
      setState(() {
        banners = value;
      });
    }));
    getMainCategories().then((value) {
      setState(() {
        data = value;
      });
    });
    getPopularServices().then((value) {
      setState(() {
        popularServices = value;
      });
    });

    getMainAndSubCategories().then((value) {
      log("Function called yaay  ${value["data"].length}");
      setState(() {
        mainAndSubCategories = value;
      });
    });

    getDateTime().then((value) {
      // log("DATE" + value.toString());

      setState(() {
        c.date.value = value.toString().substring(0, 10);
        c.weekday.value = value.weekday.toString();
      });
    });
    // log("Date"+c.date.value);
    // log("Weekday"+c.weekday.value);
  }

  @override
  Widget build(BuildContext context) {
    final double ht = MediaQuery.of(context).size.height;
    final double wd = MediaQuery.of(context).size.width;
    List<Map<String, String>> autoServices = [
      {"Title": "Car\nService", "Path": "assets/autoService/autoService.png"},
      {
        "Title": "Two-Wheeler\nService",
        "Path": "assets/autoService/autoService.png"
      },
      {
        "Title": "Breakdown\nService",
        "Path": "assets/autoService/autoService.png"
      },
      {
        "Title": "Auto &\nBody-Works",
        "Path": "assets/autoService/autoService.png"
      },
    ];
    return Scaffold(
      appBar: PreferredSize(
          child: const AppBarWidget(), preferredSize: Size(wd, wd / 6)),
      body: data == null ||
              mainAndSubCategories == null ||
              popularServices == null ||
              banners == null ||
              summerSpecial == null ||
              onGoingOffers == null
          ? Center(
              child: SizedBox(
                  height: ht / 4,
                  width: wd / 2,
                  child: ShimmerLoader(height: ht / 4, width: wd / 2)))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset("assets/HomeBanner.png"),
                    HomeBanner(data: banners),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 30, bottom: 10),
                      child: Text(
                        "What cleaning services you need?",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MainCategoriesList(
                      data: data,
                    ),
                    // SEARCH BAR
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 20, bottom: 0),
                      child: Container(
                        height: 43,
                        decoration: BoxDecoration(
                            color: const Color(0xffE5E5E5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(
                              Icons.search_outlined,
                              color: Color(0xff38456C),
                            ),
                          ),
                          Text(
                            "Search",
                            style: TextStyle(color: Color(0xff7E7D7D)),
                          )
                        ]),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 20, right: 8.0),
                      child: Text(
                        "Popular Services",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //popular services
                    popularServices == null
                        ? const Center(child: Loader())
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: PopularServicesHome(data: popularServices),
                          ),

                    //Popular Service BUtton
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: ServiceButton(
                        buttonText: "View all popular Services",
                      ),
                    ),

                    //Ongoing Offers
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              "Ongoing Offers",
                              style: TextStyle(
                                  color: Color(0xff5C5C5C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          RewardCarousel(
                            data: onGoingOffers,
                          ),
                        ],
                      ),
                    ),

                    //HOME SERVICE
                    mainAndSubCategories == null
                        ? const Loader()
                        : Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: HomeAndPersonalService(
                              data: mainAndSubCategories,
                              color: const Color(0xffF7F7F7),
                              title: "Home Service",
                            ),
                          ),
                    summerSpecial == null
                        ? const Loader()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 28.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 10),
                                  child: Text(
                                    summerSpecial["data"][0]["offer_type_name"],
                                    style: const TextStyle(
                                        color: Color(0xff5C5C5C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                SeasonalOffersCarousel(
                                  data: summerSpecial,
                                ),
                              ],
                            ),
                          ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Container(
                    //     color: Colors.black12,
                    //     child: const OtifsProducts(
                    //       color: Colors.white70,
                    //       title: "OTIFS Products",
                    //     ),
                    //   ),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Container(
                    //     color: Colors.black12,
                    //     child: const OtifsProducts(
                    //       color: Colors.white70,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Column(
                    //     children: [
                    //       OtifsProducts(color: Colors.black.withOpacity(0.05)),
                    //       Container(
                    //           color: Colors.black.withOpacity(0.05),
                    //           child: const Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child:
                    //                 ServiceButton(buttonText: "Check our products"),
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    //Service Guarantee

                    Image.asset("assets/Service Guarantee.png"),
                    //
                    Image.asset(
                      "assets/addingHappiness.png",
                      fit: BoxFit.fill,
                      width: wd,
                    ),
                    SizedBox(
                      height: wd / 4,
                    ),

                    //
                  ],
                ),
              ),
            ),
    );
  }
}
