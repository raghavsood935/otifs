import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stellar_track/widgets/loader.dart';

class RewardCarousel extends StatelessWidget {
  const RewardCarousel({required this.data, Key? key}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    print(data);
    final wd = MediaQuery.of(context).size.width;
    // print("ppppppppppppppppppppppp" + data["data"].toString());
    return data == null
        ? Loader()
        : CarouselSlider.builder(
            itemCount: data["data"].length,
            itemBuilder: ((context, index, realIndex) {
              return SizedBox(
                width: wd,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: data["data"][index]["offer_image"] == null
                      ? Loader()
                      : Image.network(
                          data["data"][index]["offer_image"],
                          fit: BoxFit.fill,
                        ),
                ),
              );
            }),
            options: CarouselOptions(
                enlargeCenterPage: false,
                padEnds: true,
                height: wd / 2.5,
                viewportFraction: 0.9,
                enableInfiniteScroll: true));
  }
}

class SeasonalOffersCarousel extends StatelessWidget {
  const SeasonalOffersCarousel({required this.data, Key? key})
      : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    final wd = MediaQuery.of(context).size.width;
    print("SUMMERSSSSSSSSSSSS" + data["data"].toString());
    return data == null
        ? Loader()
        : Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return CarouselSlider.builder(
                      itemCount: data["data"][index]["offers"].length,
                      itemBuilder: ((context, count, realIndex) {
                        return SizedBox(
                          width: wd,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white,
                            child: Image.network(
                              data["data"][index]["offers"][count]
                                  ["offer_image"],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                      options: CarouselOptions(
                          enlargeCenterPage: false,
                          padEnds: true,
                          height: wd / 2.5,
                          viewportFraction: 0.9,
                          enableInfiniteScroll: true));
                })),
          );
  }
}
