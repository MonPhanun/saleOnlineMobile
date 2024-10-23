import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';

class CarouselProductDetail extends StatelessWidget {
  const CarouselProductDetail({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => const CarouselShimmer(),
      ),
    );
  }
}
