import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saleonlinemobile/views/shares/reviewOrderCart/review_order_cart.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';

class ReviewOrderPage extends StatefulWidget {
  const ReviewOrderPage({super.key});

  @override
  State<ReviewOrderPage> createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  String groupValues = "Front door";
  double getWidth = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get width
    getWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          key: const Key('appbar'),
          toolbarHeight: 80,
          backgroundColor: Theme.of(context).primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 26,
            ),
          ),
          title: const Text(
            'Review Order',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup at store or deliver option',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Type : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text(
                                  'Pickup',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Delivery instruction (optional)',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Text(
                                    'Add access codes or other necessary information',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                                builder: (context,
                                                    StateSetter setModalState) {
                                              return instruction(setModalState);
                                            }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2,
                                            color: Colors.grey.shade600),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(12),
                          width: getWidth,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.2,
                                        color: Colors.grey.shade700),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 18),
                                  child: Text(
                                    'Leave at my door',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[700]),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.2,
                                        color: Colors.grey.shade700),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 18),
                                  child: Text(
                                    "I'll sign for my order",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[700]),
                                  ),
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(12),
                          width: getWidth,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: getWidth * .6,
                                    child: Text(
                                      'Item details',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) =>
                                              StatefulBuilder(builder: (context,
                                                  StateSetter setModalState) {
                                                return viewItemDetail(
                                                    setModalState);
                                              }));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.2,
                                              color: Colors.grey.shade600),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        child: Text(
                                          'view',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[500]),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '14 Items',
                                style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) => Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          width: 150,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 110,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "https://i.pinimg.com/236x/ca/55/d9/ca55d9686ae94bda7b84b33d76a13f70.jpg",
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CarouselShimmer(),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'HP 255 15.6 Inch G10 Business-Ready Notebook PC • 16 GB Memory • 640GB Storage(128GB SSD with 512GB Portable Drive)• AMD Ryzen 3 7730U • Windows 11 Pro • Full HD Display • AMD Radeon Graphics (2024)',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        )),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(12),
                    width: getWidth,
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal (14 items)',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                '\$14.00',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Charge Fee',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                '\$2.00',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tax',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                '\$2.00',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery charge',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                '\$2.00',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ])),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(12),
                    width: getWidth,
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Estimate total',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                '\$20.00',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(24)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: Text(
                                  'Place Order (\$20.00)',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ]))
              ],
            ),
          ),
        ));
  }

  Widget instruction(StateSetter setModalState) {
    return DraggableScrollableSheet(
        expand: false,
        snap: true,
        initialChildSize: 0.7,
        minChildSize: 0.6,
        builder: (_, controller) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: getWidth,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 6,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(18)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Property type',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.8, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "House",
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.8, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Appartment",
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.8, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Business",
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.8, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Other",
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Gate or call box code',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      placeholder: "code",
                      style: const TextStyle(fontSize: 18),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Delivery notes',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      style: const TextStyle(fontSize: 18),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8)),
                      minLines: 5,
                      maxLines: 6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Dropoff location',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioListTile<String>(
                        title: Text(
                          'Front door',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        value: 'Front door',
                        groupValue: groupValues,
                        activeColor: Theme.of(context).primaryColor,
                        fillColor: WidgetStatePropertyAll(Colors.grey[600]),
                        onChanged: (val) {
                          setModalState(() {
                            groupValues = val.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioListTile<String>(
                        title: Text(
                          'Back door',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        value: 'Back door',
                        groupValue: groupValues,
                        fillColor: WidgetStatePropertyAll(Colors.grey[600]),
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (val) {
                          setModalState(() {
                            groupValues = val.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioListTile<String>(
                        title: Text(
                          'Garage',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        value: 'Garage',
                        groupValue: groupValues,
                        fillColor: WidgetStatePropertyAll(Colors.grey[600]),
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (val) {
                          setModalState(() {
                            groupValues = val.toString();
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(22)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text('Save',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]));
        });
  }

  Widget viewItemDetail(StateSetter setModalState) {
    return DraggableScrollableSheet(
        expand: false,
        snap: true,
        initialChildSize: 0.7,
        minChildSize: 0.6,
        builder: (_, controller) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: getWidth,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 6,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(18)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Item Detail',
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) =>
                                const ReviewOrderCart(
                                  imgUrl:
                                      "https://i.pinimg.com/236x/ca/55/d9/ca55d9686ae94bda7b84b33d76a13f70.jpg",
                                  name:
                                      "HP Dragonfly G4 13.5 TS Laptop is-1335U 16GB 512GB W11P",
                                  price: 134.55,
                                  quanity: 2,
                                  totalPrice: 245.66,
                                  unit: "134.55 ",
                                  unitPrice: 134.55,
                                ))),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estimate total',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            '\$20.00',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[800]),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(22)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text('Done',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]));
        });
  }
}
