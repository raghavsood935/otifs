import 'package:flutter/material.dart';
import 'package:stellar_track/Screens/subcategoryScreen.dart';
import 'package:stellar_track/apiCalls.dart';
import 'package:stellar_track/widgets/loader.dart';

import '../Screens/serviceScreen.dart';

class MainCategoriesList extends StatefulWidget {
  const MainCategoriesList({required this.data, Key? key}) : super(key: key);
  final data;
  @override
  State<MainCategoriesList> createState() => _MainCategoriesListState();
}

class _MainCategoriesListState extends State<MainCategoriesList> {
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;

    return widget.data == null
        ? const Center(child: Loader())
        : SizedBox(
            height: wd / 2.5,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.data["data"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubcategoriesScreen(
                                    categoryId: widget.data["data"][index]["id"]
                                        .toString())));

                        // getData().then((value) {

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ServiceScreen(
                        //               data: value["data"],
                        //             )));
                        // });
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            child: SizedBox(
                              height: wd / 3.5,
                              width: wd / 5,
                              child: widget.data == null
                                  ? const Loader()
                                  : Image.network(
                                      widget.data["data"][index]
                                          ["banner_image"],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          widget.data == null
                              ? const Loader()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.data["data"][index]["name"],
                                    style: TextStyle(color: Color(0xff5C5C5C)),
                                  ),
                                )
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
