import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/category_vm.dart';
import 'package:saleonlinemobile/models/searchModel/response_search_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/headerpage/view_more_header.dart';
import 'package:saleonlinemobile/views/shares/viewMoreCart/view_more_cart.dart';

class ViewMoreProductPage extends StatefulWidget {
  const ViewMoreProductPage({super.key});

  @override
  State<ViewMoreProductPage> createState() => _ViewMoreProductPageState();
}

class _ViewMoreProductPageState extends State<ViewMoreProductPage> {
  GetCategoryVm listCategory = GetCategoryVm();
  bool isVisible = true;
  ScrollController controller = ScrollController();
  List<ResponseSearchVm> listProduct = [];
  Future<String>? temFetchData;
  String? categoryId = '';

  // ==== refresh ======
  Future<void> _handleRefresh() async {
    // delay 3 seconds
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

  // ======== get product by category ====>
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
    temFetchData = fetchData();
    // func listener
    controller.addListener(listener);
    // getx
    categoryId = Get.arguments;
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
        key: const Key('appbar'),
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        key: const Key('safe_area'),
        child: LiquidPullToRefresh(
            key: const Key('refresh'),
            color: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            animSpeedFactor: 2,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 500,
            onRefresh: _handleRefresh,
            height: 70,
            child: Column(key: const Key('content'), children: [
              const ViewMoreHeader(
                key: Key('header'),
              ),
              // category
              listCategory.listCategory != null
                  ? viewCategory()
                  : const SizedBox(
                      key: Key('category'),
                    ),

              // content
              Expanded(
                  child: FutureBuilder<String>(
                      key: const Key('future_builder'),
                      future: temFetchData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              key: const Key('list_view'),
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error : ${snapshot.error}'),
                          );
                        } else {
                          return ListView.builder(
                              key: const Key('list_view'),
                              controller: controller,
                              itemCount: listProduct.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 18),
                                    child: ViewMoreCart(
                                      imgUrl: listProduct[index].fileName,
                                      imgHeight: 230,
                                      name: listProduct[index].name,
                                      price: listProduct[index].price,
                                      unitPrice: listProduct[index].unitPrice,
                                      unit: listProduct[index].unit,
                                    ),
                                  ));
                        }
                      }))
            ])),
      ),
    );
  }

  // home category
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
}
