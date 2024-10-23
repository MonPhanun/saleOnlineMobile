import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';

class CarouselCart extends StatelessWidget {
  const CarouselCart({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CarouselShimmer(),
        ),
      ),
    );
  }
}
