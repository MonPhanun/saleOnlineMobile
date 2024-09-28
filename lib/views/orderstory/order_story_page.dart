import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/product_cart_vm.dart';
import 'package:saleonlinemobile/models/mock_var_data.dart';
import 'package:saleonlinemobile/views/shares/headerpage/order_story_header.dart';
import 'package:saleonlinemobile/views/shares/orderStoryCart/order_story_cart.dart';

class OrderStoryPage extends StatefulWidget {
  const OrderStoryPage({super.key});

  @override
  State<OrderStoryPage> createState() => _OrderStoryPageState();
}

class _OrderStoryPageState extends State<OrderStoryPage> {
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
    return LiquidPullToRefresh(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: _handleRefresh,
        height: 70,
        child: Column(children: [
          // page header
          const OrderStoryHeader(),
          // category filter
          dateTotalShip(),
          // conten cart
          Expanded(
            child: ListView(
              controller: controller,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Estimate Arriving Date : 09-2-2024',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
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
        ]));
  }

  // home category
  AnimatedContainer dateTotalShip() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: const Color.fromARGB(124, 210, 235, 255),
      height: isVisible ? 80 : 0,
      child: Center(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: isVisible
                  ? Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          topCart('Order Date', '09-27-2024'),
                          topCart('Total', '\$40.92'),
                          topCart('Ship to', 'other  . . '),
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
