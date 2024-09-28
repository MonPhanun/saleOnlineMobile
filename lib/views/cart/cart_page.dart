import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/product_cart_vm.dart';
import '../../models/mock_var_data.dart';
import '../shares/orderStoryCart/order_story_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // declear variable
  List<ProductCartVM> _product = [];

  bool isVisible = true;
  ScrollController controller = ScrollController();

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    _product = MockVarData.favoriteProduct;
    // func listener
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      setState(() {
        isVisible = true;
      });
    } else {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: searchInput(),
        ),
        body: SafeArea(
            child: LiquidPullToRefresh(
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                springAnimationDurationInMilliseconds: 500,
                onRefresh: _handleRefresh,
                height: 70,
                child: Column(children: [
                  // category filter
                  numberItem(),
                  // conten cart
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        // expend location
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: expandPickup(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Estimate Arriving Date : 09-2-2024',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _product.length,
                          itemBuilder: (context, index) => OrderStoryCart(
                            imgUrl: _product[index].imgUrl,
                            name: _product[index].name,
                            price: '${_product[index].price}',
                            currency: 'SGD',
                            localPrice: '${_product[index].localPrice}',
                          ),
                        ),
                      ],
                    ),
                  )
                ]))));
  }

  ExpansionTile expandPickup() {
    return ExpansionTile(
      minTileHeight: 40,
      dense: true,
      shape: const RoundedRectangleBorder(),
      collapsedShape: const RoundedRectangleBorder(),
      childrenPadding: const EdgeInsets.all(0),
      leading: const Icon(
        Icons.account_circle,
        color: Colors.black54,
      ),
      title: const Text(
        'Pickup and delivery option',
        style: TextStyle(fontSize: 14),
      ),
      tilePadding: const EdgeInsets.all(0),
      iconColor: Colors.black54,
      collapsedIconColor: Colors.black54,
      onExpansionChanged: (value) {},
      children: [
        const SizedBox(
          height: 8,
        ),
        // location
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: const Color.fromARGB(125, 187, 222, 251),
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

        // location house
        const SizedBox(
          height: 22,
        ),
      ],
    );
  }

  // Search haeder
  Widget searchInput() {
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

  AnimatedContainer numberItem() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 40 : 0,
      child: Center(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              child: isVisible
                  ? Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Cart',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(1 item)',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget topCart(String name, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        )
      ],
    );
  }
}
