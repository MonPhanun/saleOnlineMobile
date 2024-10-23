import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/homModel/category_vm.dart';
import 'package:saleonlinemobile/models/homModel/company_logo_vm.dart';
import 'package:saleonlinemobile/models/homModel/get_store_vm.dart';
import 'package:saleonlinemobile/models/homModel/home_product_vm.dart';
import 'package:saleonlinemobile/models/homModel/product_by_category_vm.dart';
import 'package:saleonlinemobile/models/mock_var_data.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/carousel/carousel_cart.dart';
import 'package:saleonlinemobile/views/shares/headerpage/page_header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saleonlinemobile/views/shares/productCart/product_cart.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // declear variable
  List<String> _threeCart = [];
  List<Widget> _carouselItem = [];
  Future<String>? temFetchData;
  bool isCartSponcer = false;

  bool isVisible = true;
  ScrollController controller = ScrollController();
  List<GlobalKey> itemKey = [];

  // api variable
  ListGetStoreVm listStore = ListGetStoreVm();
  CompanyLogoVm companyLogo = CompanyLogoVm();
  GetCategoryVm listCategory = GetCategoryVm();
  ListHomeProductVm listProduct = ListHomeProductVm();
  // map to view
  List<ProductByCategoryVm> productByCategory = [];

  // ======== Store ====>
  Future<dynamic> getStore() async {
    var uriStore = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.getStore}');
    var resStore = await http.get(uriStore);
    if (resStore.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resStore.body.toString());
    } else {
      throw Exception(resStore.statusCode);
    }
  }

  // ======== company logo ====>
  Future<dynamic> getCompanyLogo() async {
    var uriCompanyLogo =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.companyLogo}');
    var resCompanyLogo = await http.get(uriCompanyLogo);
    if (resCompanyLogo.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCompanyLogo.body.toString());
    } else {
      throw Exception(resCompanyLogo.statusCode);
    }
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

  // ======== category ====>
  Future<dynamic> getHomeItem() async {
    var uriHomeItem = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.homePage}');
    var resHomeItem = await http.get(uriHomeItem);
    if (resHomeItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resHomeItem.body.toString());
    } else {
      throw Exception(resHomeItem.statusCode);
    }
  }

  // fetch data from api
  Future<String>? fetchHomePageData() async {
    try {
      var store = await getStore();
      var logo = await getCompanyLogo();
      var product = await getHomeItem();
      var category = await getCategory();

      setState(() {
        listStore = ListGetStoreVm.fromjson(store);
        companyLogo = CompanyLogoVm.fromjson(logo);
        listProduct = ListHomeProductVm.fromjson(product);
        listCategory = GetCategoryVm.fromjson(category);
      });

      // map Product by category
      mapPoductByCategory();

      // return some value to trigger Furture Builder
      return "done";
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return "";
    }
  }

  // maping from list all product to list product by category
  mapPoductByCategory() {
    List<HomeProductVm> temProduct;
    setState(() {
      for (var val in listCategory.listCategory!) {
        temProduct = [];
        if (val.id != '') {
          temProduct = listProduct.listProduct!
              .where((e) => e.categoryId == val.id)
              .toList();
        } else {
          temProduct = listProduct.listProduct!;
        }

        // add position key
        itemKey.add(GlobalKey());

        // map data
        var temData =
            ProductByCategoryVm(category: val, listProduct: temProduct);
        productByCategory.add(temData);
      }
    });
  }

  Future scrollToItem(int index) async {
    final context = itemKey[index].currentContext!;
    // scroll to
    await Scrollable.ensureVisible(context,
        alignment: 0.2, duration: const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    // fetch data when inin page
    temFetchData = fetchHomePageData();

    // get values
    _carouselItem = MockVarData.carousel
        .map((e) => CarouselCart(
              imageUrl: e,
            ))
        .toList();

    _threeCart = MockVarData.threeCart;
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
    // fetch data when inin page
    temFetchData = fetchHomePageData();
    // delay 3 seconds
    return await Future.delayed(const Duration(seconds: 3));
  }

  //====

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: const Key('refresh'),
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      springAnimationDurationInMilliseconds: 500,
      onRefresh: _handleRefresh,
      height: 70,
      child: Column(
        key: const Key("content"),
        children: [
          // page header
          (listStore.getStore != null)
              ? PageHeader(
                  key: const Key('header'),
                  listStore: listStore,
                  companyLogo: companyLogo)
              : const SizedBox(key: Key('header')),

          // category
          listCategory.listCategory != null
              ? homeCategory()
              : const SizedBox(key: Key('category')),

          Expanded(
            child: FutureBuilder<String>(
                key: const Key('builder'),
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
                    return ListView(
                      key: const Key('listview_content'),
                      controller: controller,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),

                        // carousel slider
                        SizedBox(
                          height: 200,
                          child: CarouselSlider(
                              key: const Key('slider'),
                              items: _carouselItem,
                              options: CarouselOptions(
                                  viewportFraction: 0.78,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  autoPlayCurve: Curves.easeInToLinear)),
                        ),

                        SizedBox(
                          height: isCartSponcer ? 20 : 0,
                        ),

                        // cart
                        isCartSponcer ? threeCartSponcer() : const SizedBox(),

                        const SizedBox(
                          height: 30,
                        ),

                        ListView.builder(
                            key: const Key('content_cart'),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productByCategory.length,
                            itemBuilder: (context, topIndex) {
                              return Column(
                                key: itemKey[topIndex],
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          productByCategory[topIndex]
                                              .category!
                                              .name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed("/viewmore",
                                                arguments:
                                                    productByCategory[topIndex]
                                                        .category!
                                                        .id);
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: Colors.grey[400],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 270,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: productByCategory[topIndex]
                                          .listProduct!
                                          .length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(12)),
                                          ),
                                          width: Get.width * .57,
                                          child: ProductCart(
                                            onTap: () {
                                              Get.toNamed('/detail');
                                            },
                                            imgHeight: 150,
                                            imgWidth: Get.width * .57,
                                            imgUrl: productByCategory[topIndex]
                                                .listProduct![index]
                                                .fileName,
                                            name: productByCategory[topIndex]
                                                .listProduct![index]
                                                .name,
                                            price: productByCategory[topIndex]
                                                .listProduct![index]
                                                .price,
                                            unit: productByCategory[topIndex]
                                                .listProduct![index]
                                                .unit,
                                            unitPrice:
                                                productByCategory[topIndex]
                                                    .listProduct![index]
                                                    .unitPrice,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              );
                            }),

                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Container threeCartSponcer() {
    return Container(
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
                  child: CachedNetworkImage(
                    imageUrl: _threeCart[0],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CarouselShimmer(),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 196,
                width: (Get.width * .5) - 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: _threeCart[1],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CarouselShimmer(),
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
              child: CachedNetworkImage(
                imageUrl: _threeCart[2],
                fit: BoxFit.cover,
                placeholder: (context, url) => const CarouselShimmer(),
              ),
            ),
          )
        ],
      ),
    );
  }

  // home category
  AnimatedContainer homeCategory() {
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
                        scrollToItem(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 236, 236),
                            borderRadius: BorderRadius.circular(22)),
                        child: Center(
                            child: Text(
                          listCategory.listCategory![index].name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
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
