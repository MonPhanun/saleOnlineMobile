import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/productDetailModel/item_field_vm.dart';
import 'package:saleonlinemobile/models/productDetailModel/item_image_vm.dart';
import 'package:saleonlinemobile/models/productDetailModel/item_price_vm.dart';
import 'package:saleonlinemobile/models/productDetailModel/item_quantity_vm.dart';
import 'package:saleonlinemobile/models/productDetailModel/product_info_vm.dart';
import 'package:saleonlinemobile/models/productDetailModel/store_category_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/carousel/carousel_product_detail.dart';
import 'package:saleonlinemobile/views/shares/headerpage/product_detail_header.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../shimmerShare/carouselShimmer/carousel_shimmer.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // declear variable
  List<Widget> _carouselItem = [];
  int slideActive = 0;
  bool isCheck = false;
  int btsIndex = 0;
  List<String> swapImage = [];
  ScrollController controller = ScrollController();
  CarouselSliderController sliderController = CarouselSliderController();

  // api variable
  StoreCategoryVm storeCategory = StoreCategoryVm();
  ProductInfoVm productInfo = ProductInfoVm();
  ItemPriceVm itemPrice = ItemPriceVm();
  ItemQuantityVm itemQuantity = ItemQuantityVm();
  GetItemImageVm itemImage = GetItemImageVm();
  GetIteFieldVm itemField = GetIteFieldVm();
  Future<String>? temFetchData;

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  // ======== get category ====>
  Future<dynamic> getCategory() async {
    var uriCategory =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.detailCategory}');
    var resCategory = await http.get(uriCategory);
    if (resCategory.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCategory.body.toString());
    } else {
      throw Exception(resCategory.statusCode);
    }
  }

  // ======== get product info ====>
  Future<dynamic> getProductInfo() async {
    var uriProduct =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.detailProduct}');
    var resProduct = await http.get(uriProduct);
    if (resProduct.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resProduct.body.toString());
    } else {
      throw Exception(resProduct.statusCode);
    }
  }

  // ======== get item price ====>
  Future<dynamic> getItemPrice() async {
    var uriPrice =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.detailItemPrice}');
    var resPrice = await http.get(uriPrice);
    if (resPrice.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resPrice.body.toString());
    } else {
      throw Exception(resPrice.statusCode);
    }
  }

  // ======== get item quantity ====>
  Future<dynamic> getItemQty() async {
    var uriQty = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.detailItemQty}');
    var resQty = await http.get(uriQty);
    if (resQty.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resQty.body.toString());
    } else {
      throw Exception(resQty.statusCode);
    }
  }

  // ======== get item image ====>
  Future<dynamic> getImage() async {
    var uriImg = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.detailImg}');
    var resImg = await http.get(uriImg);
    if (resImg.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resImg.body.toString());
    } else {
      throw Exception(resImg.statusCode);
    }
  }

  // ======== get item field ====>
  Future<dynamic> getItemField() async {
    var uriField =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.detailItemField}');
    var resField = await http.get(uriField);
    if (resField.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resField.body.toString());
    } else {
      throw Exception(resField.statusCode);
    }
  }

  // fetch data from api
  Future<String> fetchProductDetail() async {
    try {
      var category = await getCategory();
      var info = await getProductInfo();
      var price = await getItemPrice();
      var qty = await getItemQty();
      var field = await getItemField();
      var image = await getImage();

      setState(() {
        storeCategory = StoreCategoryVm.fromJson(category);
        itemImage = GetItemImageVm.fromJson(image);
        itemQuantity = ItemQuantityVm.fromJson(qty);
        itemField = GetIteFieldVm.fromJson(field);
        productInfo = ProductInfoVm.fromJson(info);
        itemPrice = ItemPriceVm.fromJson(price);
      });

      // map image
      mapImage(itemImage);

      // get first default Capacity and
      firstDefaultCapacityAndColor();

      // return some value to trigger Furture Builder
      return "done";
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return "";
    }
  }

  List<String> unSeletedColorAndCapacityId = [];
  List<String> selectedColorAndCapacityId = [];

  // get default selected capacity and color
  defaultSelectedCapacityAndColor(String id) {
    selectedColorAndCapacityId = [];
    setState(() {
      // find colors by capacity id
      for (var e in productInfo.items!) {
        for (var val in e.itemValues!) {
          if (val == id) {
            selectedColorAndCapacityId.addAll(e.itemValues!);
          }
        }

        if (selectedColorAndCapacityId.isNotEmpty) break;
      }
    });

    // get default unselected capacity and color
    unSelectedCapacityAndColor(selectedColorAndCapacityId);
  }

  // get default unselected capacity and color
  unSelectedCapacityAndColor(List<String> selectedId) {
    unSeletedColorAndCapacityId = [];
    setState(() {
      // find unselected colors and capacity by id
      for (var e in productInfo.items!) {
        for (var val in e.itemValues!) {
          for (var las in selectedId) {
            if (val == las) {
              unSeletedColorAndCapacityId.addAll(e.itemValues!);
              break;
            }
          }
        }
      }
    });

    // remove selected from unselected color and capacity
    removeSelectedFromUnSelected(selectedId);
  }

  // remove selected from unselected color and capacity
  removeSelectedFromUnSelected(List<String> unSelectedId) {
    setState(() {
      for (var val in unSelectedId) {
        unSeletedColorAndCapacityId.remove(val);
      }
    });
  }

  // get first default capacity and color
  firstDefaultCapacityAndColor() {
    setState(() {
      for (var e in productInfo.items!) {
        if (e.isDefault) {
          selectedColorAndCapacityId.addAll(e.itemValues!);
        }
      }
    });
  }

  // func map image
  mapImage(GetItemImageVm image) {
    // clear image
    swapImage.clear();
    //swap image to display default image first
    for (var i = 0; i < image.itemImage!.length; i++) {
      if (image.itemImage![i].isDefault) {
        swapImage.insert(0, image.itemImage![i].fileName);
      } else {
        swapImage.add(image.itemImage![i].fileName);
      }
    }
    // map image to display carousel
    _carouselItem = swapImage
        .map((e) => CarouselProductDetail(
              imageUrl: e,
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();

    temFetchData = fetchProductDetail();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        child: LiquidPullToRefresh(
            key: const Key('refresh'),
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            animSpeedFactor: 2,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 500,
            onRefresh: _handleRefresh,
            height: 70,
            child: Column(key: const Key('col_content'), children: [
              // page header
              const ProductDetailHeader(
                key: Key('header'),
              ),

              // contain scroll
              Expanded(
                  child: FutureBuilder<String>(
                      key: const Key('future_builder'),
                      future: temFetchData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            key: const Key('list_view'),
                            controller: controller,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                  key: const Key('store'),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Text(
                                    storeCategory.store,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Padding(
                                  key: const Key('store_name'),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 5),
                                  child: Text(
                                    productInfo.productName,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[800]),
                                  )),
                              Padding(
                                key: const Key('store_qty'),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Icon(
                                          Icons.store_mall_directory_outlined,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Stock : ${itemQuantity.qty}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // carousel slider
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 370,
                                    child: InkWell(
                                      onTap: () {
                                        btsIndex = slideActive;
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) =>
                                                StatefulBuilder(builder:
                                                    (context,
                                                        StateSetter
                                                            setModalState) {
                                                  return showImage(
                                                      setModalState);
                                                }));
                                      },
                                      child: CarouselSlider(
                                          key: const Key('slide_image'),
                                          carouselController: sliderController,
                                          items: _carouselItem,
                                          options: CarouselOptions(
                                              height: 340,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  slideActive = index;
                                                });
                                              },
                                              autoPlay: false,
                                              viewportFraction: 1,
                                              autoPlayCurve:
                                                  Curves.easeInToLinear)),
                                    ),
                                  ),
                                  // button save
                                  Positioned(
                                    top: 0,
                                    right: 25,
                                    child: InkWell(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.16),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                offset: Offset(
                                                  0,
                                                  1,
                                                ),
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.file_upload_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // button favorite
                                  Positioned(
                                    top: 50,
                                    right: 25,
                                    child: InkWell(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.16),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                offset: Offset(
                                                  0,
                                                  1,
                                                ),
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // button zoom
                                  Positioned(
                                    top: 100,
                                    right: 25,
                                    child: InkWell(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.16),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                offset: Offset(
                                                  0,
                                                  1,
                                                ),
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.saved_search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // button play
                                  Positioned(
                                    top: 150,
                                    right: 25,
                                    child: InkWell(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.16),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                offset: Offset(
                                                  0,
                                                  1,
                                                ),
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  key: const Key('indicator'),
                                  child: _carouselItem.isNotEmpty
                                      ? AnimatedSmoothIndicator(
                                          activeIndex: slideActive,
                                          count: _carouselItem.length,
                                          effect: WormEffect(
                                              dotWidth: 10.0,
                                              dotHeight: 10.0,
                                              spacing: 14.0,
                                              paintStyle: PaintingStyle.stroke,
                                              activeDotColor: Theme.of(context)
                                                  .primaryColor),
                                          onDotClicked: (val) {
                                            sliderController.animateToPage(val);
                                            setState(() {
                                              slideActive = val;
                                            });
                                          },
                                        )
                                      : null),
                              const SizedBox(
                                height: 30,
                              ),

                              // product component
                              for (var com in productInfo.components ?? [])
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${com.name} :',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 70,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: com.components!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 5),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        defaultSelectedCapacityAndColor(com
                                                            .components![index]
                                                            .componentValueId);
                                                      },
                                                      child: Container(
                                                        width: 140,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: selectedColorAndCapacityId.contains(com
                                                                        .components![
                                                                            index]
                                                                        .componentValueId)
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                    : null,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: selectedColorAndCapacityId.contains(com.components![index].componentValueId)
                                                                        ? Theme.of(context).primaryColor
                                                                        : unSeletedColorAndCapacityId.contains(com.components![index].componentValueId)
                                                                            ? const Color.fromARGB(255, 185, 185, 185)
                                                                            : const Color.fromARGB(255, 235, 235, 235))),
                                                        child: Center(
                                                          child: Text(
                                                            com
                                                                .components![
                                                                    index]
                                                                .value,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: selectedColorAndCapacityId.contains(com
                                                                        .components![
                                                                            index]
                                                                        .componentValueId)
                                                                    ? Colors
                                                                        .white
                                                                    : unSeletedColorAndCapacityId.contains(com
                                                                            .components![
                                                                                index]
                                                                            .componentValueId)
                                                                        ? Theme.of(context)
                                                                            .colorScheme
                                                                            .primary
                                                                        : const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            199,
                                                                            199,
                                                                            199)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),

                              const SizedBox(
                                height: 20,
                              ),

                              Container(
                                color: const Color.fromARGB(255, 247, 251, 255),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: itemField.itemField != null
                                        ? itemField.itemField!.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text.rich(
                                          TextSpan(
                                              text: itemField
                                                  .itemField![index].fieldName,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                              children: [
                                                const TextSpan(text: ' : '),
                                                TextSpan(
                                                    text: itemField
                                                        .itemField![index]
                                                        .fieldValue,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 73, 73, 73)))
                                              ]),
                                        ),
                                      );
                                    }),
                              ),

                              const SizedBox(
                                height: 60,
                              )
                            ],
                          );
                        }
                      })),

              (itemPrice.price == 0.0)
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      height: 80,
                      decoration:
                          const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            0,
                          ),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            0,
                          ),
                        ),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Text(
                                '\$${itemPrice.price}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(221, 36, 36, 36),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Spacer(),
                          Icon(
                            Icons.shopping_cart_checkout_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 28,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            onTap: () {
                              fetchProductDetail();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 22),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(22)),
                              child: const Text(
                                'Buy now',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
            ])),
      ),
    );
  }

  Container checkBoxContain(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "How do you want your item?",
            style:
                TextStyle(fontSize: 18, color: Color.fromARGB(255, 75, 75, 75)),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCheck = !isCheck;
              });
            },
            child: Row(
              children: [
                Checkbox(
                  value: isCheck,
                  activeColor: Theme.of(context).primaryColor,
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  checkColor: Colors.white,
                  onChanged: (cal) {},
                ),
                Text(
                  'I want shipping & delivery saveings with ',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Text(
                  'Walmart+',
                  style: TextStyle(
                      color: Colors.blue[800], fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container getItemCart(String url, String title, String subTitle) {
    return Container(
      width: Get.width * .28,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: Colors.blue[50]),
            child: Image.network(
              url,
              width: 22,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 13,
                color: Color.fromARGB(221, 65, 65, 65),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            subTitle,
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }

  Widget showImage(StateSetter setModalState) {
    return DraggableScrollableSheet(
        expand: false,
        snap: true,
        initialChildSize: 0.8,
        minChildSize: 0.6,
        builder: (_, controller) {
          return Container(
            width: Get.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 6,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(18)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 450,
                  child: WidgetZoom(
                    heroAnimationTag: 'tag',
                    zoomWidget: CachedNetworkImage(
                      imageUrl: swapImage[btsIndex],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const CarouselShimmer(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: swapImage.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setModalState(() {
                              btsIndex = index;
                            });

                            sliderController.animateToPage(index);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 130,
                                child: CachedNetworkImage(
                                  imageUrl: swapImage[index],
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) =>
                                      const CarouselShimmer(),
                                ),
                              ),
                              btsIndex == index
                                  ? Container(
                                      width: 130,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}
