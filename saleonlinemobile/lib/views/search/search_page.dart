import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/category_vm.dart';
import 'package:saleonlinemobile/models/searchModel/response_search_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/searchCart/product_search_cart.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';
import '../shares/headerpage/search_header.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // declear variable
  bool isVisible = true;
  ScrollController controller = ScrollController();
  // res api
  Future<String>? temFuture;
  List<ResponseSearchVm> productRes = [];
  GetCategoryVm listCategory = GetCategoryVm();

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  // ======== category ====>
  Future<dynamic> getCategory() async {
    var uriCategory = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.category}');
    var resCategory = await http.get(uriCategory);
    if (resCategory.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCategory.body.toString());
    } else {
      throw Exception(resCategory.statusCode);
    }
  }

  // ======== get favorite product  ====>
  Future<dynamic> getProduct() async {
    var uriCategory = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.search}');
    var resCategory = await http.get(uriCategory);
    if (resCategory.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCategory.body.toString());
    } else {
      throw Exception(resCategory.statusCode);
    }
  }

  Future<String>? fetchData() async {
    try {
      var category = await getCategory();
      var product = await getProduct();
      setState(() {
        listCategory = GetCategoryVm.fromjson(category);
        productRes =
            (product as List).map((e) => ResponseSearchVm.fromjson(e)).toList();
      });

      return "done";
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // func listener
    controller.addListener(listener);
    // fech api
    temFuture = fetchData();
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
        key: const Key('scroll_refresh'),
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: _handleRefresh,
        height: 70,
        child: FutureBuilder<String>(
            key: const Key("future_builder"),
            future: temFuture,
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
                return Column(key: const Key('content'), children: [
                  // page header
                  const SearchHeader(key: Key('header')),

                  // sponsered
                  showSponsered(),

                  // divider
                  isVisible
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            height: 0.3,
                            color: Colors.grey[300],
                          ),
                        )
                      : const SizedBox(),

                  // category filter
                  filtterCategory(),

                  // divider
                  isVisible
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            height: 0.3,
                            color: Colors.grey[300],
                          ),
                        )
                      : const SizedBox(),

                  // contain scroll
                  Expanded(
                      child: ListView(
                    key: const Key('list_content'),
                    controller: controller,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),

                      // top cart scroll
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          key: const Key('list_small_cart'),
                          scrollDirection: Axis.horizontal,
                          itemCount: productRes.length,
                          itemBuilder: (context, index) => topProductCart(
                              productRes[index].fileName,
                              productRes[index].name),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          height: 0.2,
                          color: Color.fromARGB(226, 224, 224, 224),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          key: const Key('result'),
                          children: [
                            const Text(
                              'Results for "Text Search"',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '(1000+)',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        key: const Key('text_price'),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text(
                              'Price when purchased online',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.error_outline,
                              color: Colors.grey[600],
                              size: 18,
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      GridView.builder(
                        key: const Key('grid_view'),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 290, crossAxisCount: 1),
                        shrinkWrap: true,
                        itemCount: productRes.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ProductSearchCart(
                            imgUrl: productRes[index].fileName,
                            isSponsored: true,
                            unitPrice: productRes[index].unitPrice,
                            price: productRes[index].price,
                            priceCOZ: productRes[index].unit,
                            name: productRes[index].name,
                            count: 1,
                            isInCart: false,
                            onView: () {
                              Get.toNamed("/detail");
                            },
                          ),
                        ),
                      )
                    ],
                  ))
                ]);
              }
            }));
  }

  Widget topProductCart(String url, String name) {
    return InkWell(
      onTap: () {
        Get.toNamed("/detail");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: 110,
        child: Column(
          children: [
            SizedBox(
              height: 90,
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => const CarouselShimmer(),
              ),
            ),
            const Spacer(),
            Text(
              name,
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  // filtter category
  AnimatedContainer filtterCategory() {
    return AnimatedContainer(
      key: const Key('category'),
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 60 : 0,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 42,
              child: isVisible
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(216, 224, 224, 224),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.filter_list,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  'Filtter',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            )),
                          ),
                        ),
                        for (var val in listCategory.listCategory!)
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        216, 224, 224, 224),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                    child: Text(
                                  val.name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )),
                              ),
                            ),
                          ),
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // show sponsered
  AnimatedContainer showSponsered() {
    return AnimatedContainer(
      key: const Key('sponsered'),
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 50 : 0,
      child: Wrap(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 4),
            child: SizedBox(
              height: 42,
              child: isVisible
                  ? Row(
                      children: [
                        SizedBox(
                          height: 42,
                          width: 30,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.pinimg.com/236x/75/c7/f8/75c7f8b60abee5506aea95036351488d.jpg',
                            placeholder: (context, url) =>
                                const CarouselShimmer(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Zero suger gummles'),
                        const Spacer(),
                        Text(
                          'Sponsored',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.error_outline,
                          color: Colors.grey[400],
                          size: 18,
                        )
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
