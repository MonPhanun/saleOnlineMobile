import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saleonlinemobile/views/shimmerShare/productCartShimmer/product_cart_shimmer.dart';

class ViewMoreCart extends StatelessWidget {
  const ViewMoreCart(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.unitPrice,
      required this.imgHeight,
      this.imgWidth,
      this.unit = '',
      this.onTap});

  final String imgUrl;
  final String name;
  final double price;
  final String unit;
  final double unitPrice;
  final double imgHeight;
  final double? imgWidth;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            width: Get.width,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: imgHeight,
                width: imgWidth,
                placeholder: (context, url) => const ProductCartShimmer(),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primaryFixed),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      unit,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
                Text(
                  'Unit : $unitPrice',
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              height: 1,
              color: Color.fromARGB(251, 240, 240, 240),
            ),
          ),
        ],
      ),
    );
  }
}
