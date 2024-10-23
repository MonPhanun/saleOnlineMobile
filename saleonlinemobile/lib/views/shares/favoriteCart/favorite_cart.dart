import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../shimmerShare/carouselShimmer/carousel_shimmer.dart';

class FavoriteCart extends StatelessWidget {
  const FavoriteCart(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.unitPrice,
      required this.unit,
      this.onView,
      this.onAddCart,
      this.onTapBuy,
      this.onDelete});

  final String imgUrl;
  final String name;
  final double price;
  final double unitPrice;
  final String unit;
  final Function()? onView;
  final Function()? onAddCart;
  final Function()? onTapBuy;
  final Function(BuildContext context)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red.shade400,
            icon: Icons.delete,
            label: 'delete',
          )
        ]),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 160,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * .3,
                    child: InkWell(
                      onTap: onView,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(6),
                            right: Radius.circular(6)),
                        child: CachedNetworkImage(
                          imageUrl: imgUrl,
                          placeholder: (context, url) =>
                              const CarouselShimmer(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: SizedBox(
                      width: Get.width * .6,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed),
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
                            height: 10,
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
                          const Spacer(),
                          Row(
                            children: [
                              InkWell(
                                onTap: onAddCart,
                                child: SizedBox(
                                  height: 35,
                                  width: 40,
                                  child: Icon(
                                    Icons.shopping_cart_checkout_rounded,
                                    color: Colors.blue[400],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * .03,
                              ),
                              InkWell(
                                onTap: onTapBuy,
                                child: Container(
                                  height: 34,
                                  width: Get.width * .4,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Buy now',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(
                height: 1,
                color: Color.fromARGB(225, 236, 236, 236),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
