import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:placer/components/_parts/PreLoader.component.dart';
import 'package:placer/models/store.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PlaceCarousel extends StatelessWidget {
  late List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    return CarouselSlider(
      options: CarouselOptions(height: deviceHeight * 0.4),
      items: List<Widget>.from(store.places.selectedPlace.value.images.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.white),
              child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) => PreLoader(),
                  errorWidget: (context, url, error) {
                    print(error);
                    return Icon(Icons.error);
                  }),
            );
          },
        );
      })),
    );
  }
}
