import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    //This shimmer not specific for only carousel
    //We can use this shimmer to other cart and container
    // image as well.
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(40, 49, 49, 49),
      highlightColor: const Color.fromARGB(78, 255, 255, 255),
      child: Container(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
