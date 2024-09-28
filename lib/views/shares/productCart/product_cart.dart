import 'package:flutter/material.dart';
import 'package:saleonlinemobile/views/shimmerShare/productCartShimmer/product_cart_shimmer.dart';

class ProductCart extends StatelessWidget {
  const ProductCart(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.localPrice,
      this.dsc,
      this.onTap});

  final String imgUrl;
  final String name;
  final String price;
  final String localPrice;
  final String? dsc;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(
            imgUrl,
            loadingBuilder: shimmerImage,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$$price',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primaryFixed),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localPrice,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        'Order',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget shimmerImage(context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    } else {
      return const ProductCartShimmer();
    }
  }
}
