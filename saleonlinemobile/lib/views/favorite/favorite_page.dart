import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/category_vm.dart';
import 'package:saleonlinemobile/models/mock_var_data.dart';
import 'package:saleonlinemobile/models/searchModel/response_search_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/favoriteCart/favorite_cart.dart';
import 'package:saleonlinemobile/views/shares/headerpage/favorite_header.dart';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // declear variable
  List<String> _filtter = [];
  GetCategoryVm listCategory = GetCategoryVm();
  bool isVisible = true;
  ScrollController controller = ScrollController();
  List<ResponseSearchVm> listProduct = [];
  Future<String>? temFetchData;
  String categoryId = '';

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
    var uriCategory = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.viewMore}');
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
        listProduct =
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

    _filtter = MockVarData.favoriteFiltter;
    //category
    temFetchData = fetchData();
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
        key: const Key('scroll_refresh'),
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: _handleRefresh,
        height: 70,
        child: Column(key: const Key("content"), children: [
          // page header
          const FavoriteHeader(
            key: Key('header'),
          ),
          // category
          listCategory.listCategory != null
              ? viewCategory()
              : const SizedBox(
                  key: Key('category'),
                ),

          Expanded(
              child: FutureBuilder<String>(
                  key: const Key("future_builder"),
                  future: temFetchData,
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
                      return ListView.builder(
                        controller: controller,
                        itemCount: listProduct.length,
                        itemBuilder: (context, index) => FavoriteCart(
                          imgUrl: listProduct[index].fileName,
                          unit: listProduct[index].unit,
                          unitPrice: listProduct[index].unitPrice,
                          price: listProduct[index].price,
                          name: listProduct[index].name,
                          onView: () {
                            Get.toNamed("/detail");
                          },
                        ),
                      );
                    }
                  }))
        ]));
  }

  AnimatedContainer viewCategory() {
    return AnimatedContainer(
      key: const Key('category'),
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 48 : 0,
      child: Wrap(
        children: [
          SizedBox(
            height: 48,
            child: isVisible
                ? ListView.builder(
                    itemCount: listCategory.listCategory != null
                        ? listCategory.listCategory!.length
                        : 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          categoryId = listCategory.listCategory![index].id;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                            color: (categoryId ==
                                    listCategory.listCategory![index].id)
                                ? Colors.blue[300]
                                : const Color.fromARGB(255, 236, 236, 236),
                            borderRadius: BorderRadius.circular(22)),
                        child: Center(
                            child: Text(
                          listCategory.listCategory![index].name,
                          style: TextStyle(
                              color: (categoryId ==
                                      listCategory.listCategory![index].id)
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary),
                        )),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
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
