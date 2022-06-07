import 'package:flutter/material.dart';
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

    return SizedBox(
      height: wd / 2.5,
      child: widget.data == null
          ? const Loader()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount:
                  //  2,
                  widget.data["data"].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      getData().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceScreen(
                                      data: value["data"],
                                    )));
                      });
                    },
                    child: Column(
                      children: [
                        Card(
                          child: SizedBox(
                            height: wd / 4,
                            width: wd / 4,
                            child: widget.data == null
                                ? const Loader()
                                : Image.network(
                                    widget.data["data"][index]["banner_image"],
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        widget.data == null
                            ? const Loader()
                            : Text(widget.data["data"][index]["name"])
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
