import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stellar_track/Screens/serviceScreen.dart';
import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/widgets/bottomNav.dart';
import 'package:stellar_track/widgets/loader.dart';
import 'package:stellar_track/widgets/shimmerLoader.dart';

class SubcategoriesScreen extends StatefulWidget {
  const SubcategoriesScreen({required this.categoryId, Key? key})
      : super(key: key);
  final String categoryId;
  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubcategories(widget.categoryId).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  var data;

  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton:
          SizedBox(height: wd / 4.8, child: BottomNavigation()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      body: data == null
          ? Center(
              child: ShimmerLoader(
              height: 50,
              width: wd,
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
                        data["data"][0]['main_category_image'],
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            data["data"][0]["main_category_name"],
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Image.asset(
                            "assets/AppBarCall.png",
                            // width: 30,
                            height: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Icon(
                            Icons.bookmark,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ht / 2,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: data["data"][0]["sub_categories"].length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            log(data.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ServiceScreen(
                                      mainCatImage: data["data"][0]
                                          ["main_category_image"],
                                      mainCatID: widget.categoryId,
                                      subCatID: data["data"][0]
                                              ["sub_categories"][index]
                                          ["sub_category_id"],
                                    )),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Card(
                              child: SubCategoryListItem(
                                data: data,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: wd / 3.6,
                  )
                ],
              ),
            ),
    );
  }
}

class SubCategoryListItem extends StatelessWidget {
  const SubCategoryListItem({required this.data, Key? key}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    log("ffffffffffffff" +
        data["data"][0]["sub_categories"][0]["services_count"].toString());
    var wd = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  data["data"][0]["main_category_image"],
                  width: wd / 4,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: wd,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data["data"][0]["sub_categories"][0]
                                        ["sub_category_name"]
                                    .toString(),
                                style: const TextStyle(
                                    color: Color(0xff5C5C5C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_right)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      data["data"][0]["sub_categories"][0]["services_count"]
                              .toString() +
                          "  Services",
                      style: const TextStyle(
                          color: Color(0xffBABABA),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Text(
                      "This is the two line description of the service that can be customised form the backend",
                      style: TextStyle(
                          color: Color(0xff7E7D7D),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        // const Divider(
        //   thickness: 2,
        // )
      ],
    );
  }
}
