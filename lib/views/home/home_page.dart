import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/product_cart_vm.dart';
import 'package:saleonlinemobile/models/mock_var_data.dart';
import 'package:saleonlinemobile/views/shares/carousel/carousel_cart.dart';
import 'package:saleonlinemobile/views/shares/headerpage/page_header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saleonlinemobile/views/shares/productCart/product_cart.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // declear variable
  List<String> _category = [];
  List<String> _threeCart = [];
  List<Widget> _carouselItem = [];
  List<ProductCartVM> _product = [];

  bool isVisible = true;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // get values
    _carouselItem = MockVarData.carousel
        .map((e) => CarouselCart(
              imageUrl: e,
            ))
        .toList();
    _threeCart = MockVarData.threeCart;
    _category = MockVarData.homeCategory;
    _product = MockVarData.homeProduct;
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

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  //====

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
      child: Column(
        children: [
          // page header
          const PageHeader(),
          // category
          homeCategory(),
          Expanded(
            child: ListView(
              controller: controller,
              children: [
                const SizedBox(
                  height: 20,
                ),

                // carousel slider
                SizedBox(
                  height: 200,
                  child: CarouselSlider(
                      items: _carouselItem,
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayCurve: Curves.easeInToLinear)),
                ),

                const SizedBox(
                  height: 20,
                ),

                // cart
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 350,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 145,
                            width: (Get.width * .5) - 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                _threeCart[0],
                                fit: BoxFit.cover,
                                loadingBuilder: shimmerImage,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 196,
                            width: (Get.width * .5) - 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                _threeCart[1],
                                fit: BoxFit.cover,
                                loadingBuilder: shimmerImage,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 350,
                        width: (Get.width * .5) - 24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            _threeCart[2],
                            fit: BoxFit.cover,
                            loadingBuilder: shimmerImage,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: MasonryGridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: _product.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ProductCart(
                        imgUrl: _product[index].imgUrl,
                        name: _product[index].name,
                        price: '${_product[index].price}',
                        localPrice:
                            '${_product[index].currency} ${_product[index].localPrice}',
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // show progressing when image loarding
  Widget shimmerImage(context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    } else {
      return const CarouselShimmer();
    }
  }

  // home category
  AnimatedContainer homeCategory() {
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
                          'Departments',
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
                      for (var val in _category)
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                                child: Text(
                              val,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 224, 224, 224)),
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
