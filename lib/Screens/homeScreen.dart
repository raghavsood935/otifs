
import 'package:flutter/material.dart';
import 'package:stellar_track/widgets/carousel.dart';
import 'package:stellar_track/widgets/homeAndPersonalService.dart';
import 'package:stellar_track/widgets/loader.dart';
import 'package:stellar_track/widgets/mainCategoriesList.dart';
import 'package:stellar_track/widgets/otifsProducts.dart';
import 'package:stellar_track/widgets/serviceButton.dart';

import '../apiCalls.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  var mainAndSubCategories;
  var popularServices;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      setState(() {
        mainAndSubCategories = value;
      });
      print("Function called yaay  $value");
      print(mainAndSubCategories);
    });
  }

  @override
  Widget build(BuildContext context) {
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
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        flexibleSpace: Center(
          child: Row(
            children: [
              Image.asset(
                "assets/AppBarLeading.png",
                width: wd / 2,
              ),
              Image.asset(
                "assets/AppBarCall.png",
                width: wd / 10,
                height: 28,
              ),
              Image.asset(
                "assets/AppBarNotification.png",
                width: wd / 10,
                height: 28,
              ),
              Image.asset(
                "assets/AppBarOffer.png",
                width: wd / 4,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/HomeBanner.png"),
              const Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
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
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.search_outlined),
                    ),
                    Text("Search")
                  ]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Text(
                  "Popular services",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              popularServices == null
                  ? const Loader()
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: popularServices["data"].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: wd / 1.8,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: SizedBox(
                                  height: wd / 2.4,
                                  width: wd / 2,
                                  child: Image.network(
                                    popularServices["data"][index]
                                        ["product_image"]!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                popularServices["data"][index]["product_name"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }),
              //Popular Service BUtton
              const ServiceButton(
                buttonText: "View all popular Services",
              ),

              //Ongoing Offers
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Ongoing Offers",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                    RewardCarousel(
                      path: "assets/onGoingOffers.png",
                    ),
                  ],
                ),
              ),

              //HOME SERVICE
              mainAndSubCategories == null
                  ? const Loader()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeAndPersonalService(
                        data: mainAndSubCategories,
                        color: Colors.black12,
                        title: "Home Service",
                      ),
                    ),
              //Personal Service
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: HomeAndPersonalService(
              //     data: mainAndSubCategories,
              //     color: Colors.black12,
              //     title: "Personal Service",
              //   ),
              // ),

              ////  AUTO SERVICES
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Text(
                  "Auto services",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),

              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: wd / 1.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: SizedBox(
                              height: wd / 2.4,
                              width: wd / 2,
                              child: Image.asset(
                                autoServices[index]["Path"]!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            autoServices[index]["Title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }),
              //periodic help subscribe
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
              //   child: HomeAndPersonalService(
              //       data: mainAndSubCategories,
              //       title: "Periodic Help-Subscribe",
              //       color: Colors.transparent),
              // ),
              const ServiceButton(buttonText: "Create custom Subscription"),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Summer Special",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                    RewardCarousel(
                      path: "assets/summerBugControl.png",
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: Colors.black12,
                  child: const OtifsProducts(
                    color: Colors.white70,
                    title: "OTIFS Products",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: Colors.black12,
                  child: const OtifsProducts(
                    color: Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    OtifsProducts(color: Colors.black.withOpacity(0.05)),
                    Container(
                        color: Colors.black.withOpacity(0.05),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              ServiceButton(buttonText: "Check our products"),
                        ))
                  ],
                ),
              ),
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
