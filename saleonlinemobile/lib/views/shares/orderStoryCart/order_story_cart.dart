import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../shimmerShare/carouselShimmer/carousel_shimmer.dart';

class OrderStoryCart extends StatelessWidget {
  const OrderStoryCart(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.unitPrice,
      required this.total,
      required this.unit,
      required this.quantity,
      this.onAddCart,
      this.onTapBuy,
      this.onDelete});

  final String imgUrl;
  final String name;
  final double price;
  final double unitPrice;
  final double total;
  final String unit;
  final int quantity;
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
              height: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(6), right: Radius.circular(6)),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        placeholder: (context, url) => const CarouselShimmer(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$$price',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(192, 0, 0, 0)),
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
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                'Unit :',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                unit,
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                'quantity :',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$quantity",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '\$$total',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(
                height: 0.1,
                color: Color.fromARGB(146, 224, 224, 224),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
