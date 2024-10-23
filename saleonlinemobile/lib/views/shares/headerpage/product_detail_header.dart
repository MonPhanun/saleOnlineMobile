import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/homeState/home_state_provider.dart';

class ProductDetailHeader extends StatefulWidget {
  const ProductDetailHeader({super.key});

  @override
  State<ProductDetailHeader> createState() => _ProductDetailHeaderState();
}

class _ProductDetailHeaderState extends State<ProductDetailHeader> {
  // declear variable
  bool colap = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStateProvider>(builder: (context, value, child) {
      return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),

            // func input search
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child: searchInput(context)),
                const SizedBox(
                  width: 10,
                ),
                orderCart(value.lengthItemInCart)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // expend location
            ExpansionTile(
              minTileHeight: 40,
              dense: true,
              shape: const RoundedRectangleBorder(),
              collapsedShape: const RoundedRectangleBorder(),
              childrenPadding: const EdgeInsets.all(0),
              leading: colap
                  ? const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    )
                  : null,
              title: colap
                  ? const Text(
                      'How do you want your item?',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  : const Center(
                      child: Text(
                        'How do you want your item?',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
              tilePadding: const EdgeInsets.all(0),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              onExpansionChanged: (value) {
                setState(() {
                  colap = !value;
                });
              },
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    chooseGetItem(
                        'https://cdn-icons-png.flaticon.com/128/10918/10918283.png',
                        'Shipping',
                        30),
                    chooseGetItem(
                        'https://cdn-icons-png.flaticon.com/128/2481/2481797.png',
                        'Pickup',
                        30),
                    chooseGetItem(
                        'https://cdn-icons-png.flaticon.com/128/17378/17378761.png',
                        'Delivery',
                        30),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // location
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        '1405 Lighthouse Ln,Allen, TX, 75013',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                // location house
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Allen Supercenter',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Text(
                            '1405 Lighthouse Ln,Allen, TX, 75013',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  height: 3,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  // colape choose category to get item
  Widget chooseGetItem(String url, String name, double width) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: Colors.blue[50]),
          child: Image.network(
            url,
            width: width,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        )
      ],
    );
  }

  // Search haeder
  CupertinoTextField searchInput(BuildContext context) {
    return CupertinoTextField(
      keyboardType: TextInputType.none,
      padding: const EdgeInsets.symmetric(vertical: 8),
      placeholder: 'Search . . .',
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8, right: 4),
        child: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      style: const TextStyle(fontSize: 16),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          Icons.qr_code_scanner,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  // order cart
  Widget orderCart(int number) {
    return InkWell(
      onTap: () {
        Get.toNamed('/cart');
      },
      child: Column(
        children: [
          Badge(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            label: Text('$number'),
            child: const Padding(
              padding: EdgeInsets.only(top: 4, right: 4),
              child: FaIcon(
                FontAwesomeIcons.cartShopping,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          // const Text(
          //   '\$0.00',
          //   style: TextStyle(color: Colors.white, fontSize: 12),
          // ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
