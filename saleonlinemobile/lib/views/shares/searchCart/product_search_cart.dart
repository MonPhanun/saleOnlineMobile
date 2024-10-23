import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saleonlinemobile/views/shimmerShare/productCartShimmer/product_cart_shimmer.dart';

class ProductSearchCart extends StatelessWidget {
  const ProductSearchCart(
      {super.key,
      required this.imgUrl,
      required this.isSponsored,
      required this.price,
      required this.unitPrice,
      required this.priceCOZ,
      required this.name,
      required this.count,
      required this.isInCart,
      this.onView,
      this.onSubscribe,
      this.onAddToCart,
      this.onAddMore,
      this.onRemove});

  final String imgUrl;
  final bool isSponsored;
  final double price;
  final double unitPrice;
  final String priceCOZ;
  final String name;
  final int count;
  final bool isInCart;
  final Function()? onView;
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
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              InkWell(
                onTap: onView,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: 160,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    placeholder: (context, url) => const ProductCartShimmer(),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
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
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            'Unit Price',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$unitPrice',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          )
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
                        height: 2,
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
                  width: MediaQuery.of(context).size.width * .47,
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
                      width: MediaQuery.of(context).size.width * .47,
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
                        width: MediaQuery.of(context).size.width * .47,
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
            height: 25,
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
}
