import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderStoryHeader extends StatefulWidget {
  const OrderStoryHeader({super.key});

  @override
  State<OrderStoryHeader> createState() => _OrderStoryHeaderState();
}

class _OrderStoryHeaderState extends State<OrderStoryHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Hi, Sereyroath',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Column(
                children: [
                  Badge(
                    backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                    label: const Text('5'),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4, right: 4),
                      child: FaIcon(
                        FontAwesomeIcons.cartShopping,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const Text(
                    '\$0.00',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // func input search
          searchInput(context),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  // Search haeder
  CupertinoTextField searchInput(BuildContext context) {
    return CupertinoTextField(
      keyboardType: TextInputType.none,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 18),
      placeholder: 'Search Walmart',
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      style: const TextStyle(fontSize: 16),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
