import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../shimmerShare/carouselShimmer/carousel_shimmer.dart';

class SaveForLaterCart extends StatelessWidget {
  const SaveForLaterCart(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.unitPrice,
      required this.totalPrice,
      required this.unit,
      required this.quanity,
      this.onMove,
      this.onRemove,
      this.onDelete});

  final String imgUrl;
  final String name;
  final double price;
  final double unitPrice;
  final double totalPrice;
  final String unit;
  final int quanity;
  final Function()? onMove;
  final Function()? onRemove;
  final Function(BuildContext context)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red.shade400,
            icon: Icons.delete,
            label: 'Remove',
          )
        ]),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(
                    0,
                    1,
                  ),
                ),
                BoxShadow(
                  color: Color.fromRGBO(31, 35, 39, 0.055),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(
                    0,
                    0,
                  ),
                ),
              ]),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * .25,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(6),
                            right: Radius.circular(4)),
                        child: CachedNetworkImage(
                          imageUrl: imgUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              const CarouselShimmer(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      child: SizedBox(
                        width: Get.width * .55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '\$$price',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed,
                                  ),
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
                              height: 4,
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
                                  '\$$unitPrice',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'quantity :',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '$quanity',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'total :',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '\$$totalPrice',
                                  style: TextStyle(color: Colors.grey[400]),
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
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline_outlined,
                              color: Colors.grey[500]),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Remove',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500]),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onMove,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.replay, color: Colors.blue[200]),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Move to cart',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[300]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
