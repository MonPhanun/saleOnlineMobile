import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/homeState/home_state_provider.dart';
import 'package:saleonlinemobile/views/searchDelegate/search_delegate.dart';

class ViewMoreHeader extends StatefulWidget {
  const ViewMoreHeader({super.key});

  @override
  State<ViewMoreHeader> createState() => _ViewMoreHeaderState();
}

class _ViewMoreHeaderState extends State<ViewMoreHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStateProvider>(builder: (context, value, child) {
      return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value.primaryStore.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/cart');
                  },
                  child: Column(
                    children: [
                      Badge(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryFixed,
                        label: Text('${value.lengthItemInCart}'),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4, right: 4),
                          child: FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      // const Text(
                      //   '\$0.00',
                      //   style: TextStyle(color: Colors.white, fontSize: 12),
                      // ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // func input search
            searchInput(context),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      );
    });
  }

  // Search haeder
  Widget searchInput(BuildContext context) {
    return Row(
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
        Expanded(
          child: CupertinoTextField(
            keyboardType: TextInputType.none,
            readOnly: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            placeholder: 'Search Walmart',
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
            onTap: () {
              showSearch(context: context, delegate: SearchProductDelegate());
            },
          ),
        ),
      ],
    );
  }
}
