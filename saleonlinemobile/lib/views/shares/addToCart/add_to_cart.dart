import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../shimmerShare/carouselShimmer/carousel_shimmer.dart';

class AddToCart extends StatelessWidget {
  const AddToCart(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.unit,
      required this.originalPrice,
      required this.unitPrice,
      required this.quantity,
      this.isDiscount = false,
      this.onTapAdd,
      this.onTapSub,
      this.onSaveLater,
      this.onRemove,
      this.onDelete});

  final String imgUrl;
  final String name;
  final double price;
  final String unit;
  final double originalPrice;
  final double unitPrice;
  final int quantity;
  final bool isDiscount;
  final Function()? onTapAdd;
  final Function()? onTapSub;
  final Function()? onSaveLater;
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
                height: 160,
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
                                isDiscount
                                    ? Text.rich(TextSpan(
                                        text: '\$$price ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryFixed,
                                        ),
                                        children: [
                                            TextSpan(
                                                text: ' \$$originalPrice',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryFixed,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary))
                                          ]))
                                    : Text(
                                        '\$$originalPrice',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    onTap: onSaveLater,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark_border_outlined,
                              color: Colors.blue[200]),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Save for later',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[300]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * .3,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: onTapSub,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.remove,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700),
                        ),
                        InkWell(
                          onTap: onTapAdd,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
