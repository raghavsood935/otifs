import 'package:flutter/material.dart';

class PopularServicesHome extends StatefulWidget {
  const PopularServicesHome({required this.data, Key? key}) : super(key: key);
  final data;
  @override
  State<PopularServicesHome> createState() => _PopularServicesHomeState();
}

class _PopularServicesHomeState extends State<PopularServicesHome> {
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;

    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data["data"].length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // mainAxisExtent: wd / 2.5,
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
                    height: wd / 3,
                    width: wd / 2,
                    child: Image.network(
                      widget.data["data"][index]["product_image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  widget.data["data"][index]["product_name"].toString(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xff5C5C5C),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        });
  }
}
