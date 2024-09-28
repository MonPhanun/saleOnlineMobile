import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saleonlinemobile/views/shimmerShare/productCartShimmer/product_cart_shimmer.dart';

class ProductSearchCart extends StatelessWidget {
  const ProductSearchCart(
      {super.key,
      required this.imgUrl,
      required this.isBestSeller,
      required this.isSponsored,
      required this.price,
      required this.priceCOZ,
      required this.name,
      required this.count,
      required this.isInCart,
      this.onSubscribe,
      this.onAddToCart,
      this.onAddMore,
      this.onRemove});

  final String imgUrl;
  final bool isBestSeller;
  final bool isSponsored;
  final double price;
  final String priceCOZ;
  final String name;
  final int count;
  final bool isInCart;
  final Function()? onSubscribe;
  final Function()? onAddToCart;
  final Function()? onAddMore;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isBestSeller
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(88, 136, 199, 250),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    "Best seller",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.blue[700]),
                  ),
                )
              : const SizedBox(
                  height: 5,
                ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * .4,
                height: 160,
                child: Image.network(
                  imgUrl,
                  loadingBuilder: shimmerImage,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                  width: Get.width * .5,
                  height: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isSponsored
                          ? Text(
                              'Sponsored',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          : const SizedBox(
                              height: 5,
                            ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$$price',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            priceCOZ,
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          Icon(
                            Icons.star_border,
                            size: 14,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                          Text(
                            '138',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Save with W+',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            'Pickup',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'today',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Delivery',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'today',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onSubscribe,
                child: Container(
                  width: Get.width * .47,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sync,
                        color: Color.fromARGB(255, 77, 77, 77),
                      ),
                      Text(
                        'Subscribe',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 77, 77, 77)),
                      )
                    ],
                  ),
                ),
              ),
              isInCart
                  ? Container(
                      width: Get.width * .47,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onRemove,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '$count',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          InkWell(
                            onTap: onAddMore,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: onAddToCart,
                      child: Container(
                        width: Get.width * .47,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor),
                        child: const Center(
                          child: Text(
                            'Add to cart',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              height: 0.2,
              color: Color.fromARGB(226, 224, 224, 224),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
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
