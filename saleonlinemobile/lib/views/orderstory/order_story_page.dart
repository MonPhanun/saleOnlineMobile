import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/orderStoryModel/order_story_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/headerpage/order_story_header.dart';
import 'package:saleonlinemobile/views/shares/orderStoryCart/order_story_cart.dart';
import 'package:http/http.dart' as http;

class OrderStoryPage extends StatefulWidget {
  const OrderStoryPage({super.key});

  @override
  State<OrderStoryPage> createState() => _OrderStoryPageState();
}

class _OrderStoryPageState extends State<OrderStoryPage> {
  // declear variable
  List<OrderStoryVm> _product = [];
  Future<String>? temfuture;
  bool isVisible = true;
  ScrollController controller = ScrollController();

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  // ======== get favorite product  ====>
  Future<dynamic> getOrderStory() async {
    var uriProduct =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.orderStory}');
    var resProduct = await http.get(uriProduct);
    if (resProduct.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resProduct.body.toString());
    } else {
      throw Exception(resProduct.statusCode);
    }
  }

  Future<String>? fetchData() async {
    try {
      var orderStory = await getOrderStory();

      setState(() {
        _product =
            (orderStory as List).map((e) => OrderStoryVm.fromjson(e)).toList();
      });

      return "done";
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    temfuture = fetchData();
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
        key: const Key("scroll_refresh"),
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: _handleRefresh,
        height: 70,
        child: Column(key: const Key("content"), children: [
          // page header
          const OrderStoryHeader(
            key: Key("header"),
          ),
          // category filter
          dateTotalShip(),
          // conten cart
          Expanded(
            child: FutureBuilder<String>(
                key: const Key("future_builder"),
                future: temfuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error : ${snapshot.error}'),
                    );
                  } else {
                    return ListView(
                      key: const Key("listview_content"),
                      controller: controller,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          key: const Key("date_content"),
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
                          key: const Key("product_cart"),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _product.length,
                          itemBuilder: (context, index) => OrderStoryCart(
                            imgUrl: _product[index].imageUrl,
                            name: _product[index].itemName,
                            price: _product[index].price,
                            unit: _product[index].unit,
                            unitPrice: _product[index].unitPrice,
                            quantity: _product[index].quantity,
                            total: _product[index].totalOriginalPrice,
                          ),
                        ),
                      ],
                    );
                  }
                }),
          )
        ]));
  }

  // home category
  AnimatedContainer dateTotalShip() {
    return AnimatedContainer(
      key: const Key("cart_total"),
      duration: const Duration(milliseconds: 200),
      color: const Color.fromARGB(221, 243, 249, 255),
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
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        )
      ],
    );
  }
}
