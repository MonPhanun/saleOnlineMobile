import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/product_cart_vm.dart';
import 'package:saleonlinemobile/models/mock_var_data.dart';
import 'package:saleonlinemobile/views/shares/favoriteCart/favorite_cart.dart';
import 'package:saleonlinemobile/views/shares/headerpage/favorite_header.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // declear variable
  List<String> _filtter = [];
  List<ProductCartVM> _product = [];

  bool isVisible = true;
  ScrollController controller = ScrollController();

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    _filtter = MockVarData.favoriteFiltter;
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
          const FavoriteHeader(),
          // category filter
          favoriteCategory(),
          Expanded(
              child: ListView.builder(
            controller: controller,
            itemCount: _product.length,
            itemBuilder: (context, index) => FavoriteCart(
              imgUrl: _product[index].imgUrl,
              name: _product[index].name,
              price: '${_product[index].price}',
              currency: 'SGD',
              localPrice: '${_product[index].localPrice}',
            ),
          ))
        ]));
  }

  // home category
  AnimatedContainer favoriteCategory() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 40 : 0,
      color: const Color.fromARGB(255, 21, 82, 133),
      child: Wrap(
        children: [
          SizedBox(
            height: 40,
            child: isVisible
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                            child: Text(
                          'Filtter',
                          style: TextStyle(
                              color: Color.fromARGB(255, 224, 224, 224)),
                        )),
                      ),
                      const Center(
                          child: Text(
                        '|',
                        style: TextStyle(
                            color: Color.fromARGB(255, 224, 224, 224)),
                      )),
                      for (var val in _filtter)
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                                child: Text(
                              val,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 194, 194, 194)),
                            )),
                          ),
                        ),
                    ],
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
