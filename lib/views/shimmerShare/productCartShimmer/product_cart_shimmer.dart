import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCartShimmer extends StatelessWidget {
  const ProductCartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(40, 49, 49, 49),
      highlightColor: const Color.fromARGB(78, 255, 255, 255),
      child: Container(
        height: 210,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
