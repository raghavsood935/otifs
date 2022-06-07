import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RewardCarousel extends StatelessWidget {
  const RewardCarousel({required this.path, Key? key}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    final wd = MediaQuery.of(context).size.width;
    return CarouselSlider(
        items: [
          SizedBox(
            width: wd,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Image.asset(
                path,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
        options: CarouselOptions(
            enlargeCenterPage: true,
            padEnds: true,
            height: wd / 3,
            viewportFraction: 0.7,
            enableInfiniteScroll: true));
  }
}
