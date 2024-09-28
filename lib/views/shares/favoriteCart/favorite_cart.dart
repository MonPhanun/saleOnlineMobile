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
      required this.currency,
      required this.localPrice,
      this.dsc,
      this.onAddCart,
      this.onTapBuy,
      this.onDelete});

  final String imgUrl;
  final String name;
  final String price;
  final String currency;
  final String localPrice;
  final String? dsc;
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
        child: Container(
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              SizedBox(
                width: Get.width * .4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(6), right: Radius.circular(6)),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const CarouselShimmer();
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: SizedBox(
                  width: Get.width * .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '\$$price',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primaryFixed),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '$currency $localPrice',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary),
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
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            onTap: onTapBuy,
                            child: Container(
                              height: 34,
                              width: Get.width * .35,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
