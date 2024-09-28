import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../shimmerShare/carouselShimmer/carousel_shimmer.dart';

class OrderStoryCart extends StatelessWidget {
  const OrderStoryCart(
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
                            '13.3 c/oz',
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
                            '1',
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
                            '\$13.3',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.primaryFixed),
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
      ),
    );
  }
}
