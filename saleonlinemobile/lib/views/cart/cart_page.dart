import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/models/cartModel/cart_item_price_vm.dart';
import 'package:saleonlinemobile/models/cartModel/cart_item_vm.dart';
import 'package:saleonlinemobile/models/cartModel/cart_local_storage_vm.dart';
import 'package:saleonlinemobile/models/cartModel/charging_fee_vm.dart';
import 'package:saleonlinemobile/models/cartModel/view_cart_vm.dart';
import 'package:saleonlinemobile/models/saveLaterModel/save_later_item_price_vm.dart';
import 'package:saleonlinemobile/models/saveLaterModel/save_later_item_vm.dart';
import 'package:saleonlinemobile/models/saveLaterModel/save_later_local_store_vm.dart';
import 'package:saleonlinemobile/models/saveLaterModel/view_save_later_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/stateProvider/fileService/file_repo_controller.dart';
import 'package:saleonlinemobile/views/shares/addToCart/add_to_cart.dart';
import 'package:saleonlinemobile/views/shares/addToCart/save_for_later_cart.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // declear variable
  ScrollController controller = ScrollController();
  Future<String>? temResponse;
  // api variable
  List<CartLocalStorageVm> listItemLocal = [];
  List<CartItemVm> listItem = [];
  List<CartItemPriceVm> listItemPrice = [];
  List<ChargingFeeVm> chargingFee = [];
  // save later use
  List<SaveLaterLocalStoreVm> listSaveItemLocal = [];
  List<SaveLaterItemVm> listSaveItem = [];
  List<SaveLaterItemPriceVm> listSaveItemPrice = [];
  // view item
  List<ViewCartVm> viewItem = [];
  List<ViewSaveLaterVm> viewSaveLater = [];
  // total price
  double subTotal = 0.0;
  double priceSaveing = 0.0;
  double estimatedTotal = 0.0;

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  /// ======== cart ====>
  Future<dynamic> getLocal() async {
    var uriLocal = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.cartLocal}');
    var resLocal = await http.get(uriLocal);
    if (resLocal.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Provider.of<FileRepoController>(context, listen: false)
          .writeJsonFile("cart", resLocal.body.toString());

      // return some value to trigger Furture Builder
      return jsonDecode(resLocal.body.toString());
    } else {
      throw Exception(resLocal.statusCode);
    }
  }

  // read file or get api func
  Future<dynamic> readFileOrGetApi() async {
    // ignore: use_build_context_synchronously
    return await Provider.of<FileRepoController>(context, listen: false)
        .readJsonFile("cart")
        .then((val) async {
      if (val == '') {
        var dataResponse = await getLocal();
        return dataResponse;
      } else {
        // ignore: avoid_print
        print('item in cart read file');

        return jsonDecode(val.toString());
      }
    });
  }

  Future<dynamic> getItem() async {
    var uriItem = Uri.parse('${dotenv.env['baseUrl']}${EndPoint.cartGetItem}');
    var resItem = await http.get(uriItem);
    if (resItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItem.body.toString());
    } else {
      throw Exception(resItem.statusCode);
    }
  }

  Future<dynamic> getItemPrice() async {
    var uriPrice =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.cartGetPriceitem}');
    var resPrice = await http.get(uriPrice);
    if (resPrice.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resPrice.body.toString());
    } else {
      throw Exception(resPrice.statusCode);
    }
  }

  Future<dynamic> getChargeFee() async {
    var uriChargeFee =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.chargingFee}');
    var resChargeGee = await http.get(uriChargeFee);
    if (resChargeGee.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resChargeGee.body.toString());
    } else {
      throw Exception(resChargeGee.statusCode);
    }
  }

  // ====== save later use ===>
  Future<dynamic> getlocalSave() async {
    var uriLocalSavelater =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.saveLaterlocal}');
    var resLocalSavelater = await http.get(uriLocalSavelater);
    if (resLocalSavelater.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Provider.of<FileRepoController>(context, listen: false)
          .writeJsonFile("savelater", resLocalSavelater.body.toString());

      // return some value to trigger Furture Builder
      return jsonDecode(resLocalSavelater.body.toString());
    } else {
      throw Exception(resLocalSavelater.statusCode);
    }
  }

  // read save later file or get api func
  Future<dynamic> readSaveFileOrGetApi() async {
    // ignore: use_build_context_synchronously
    return await Provider.of<FileRepoController>(context, listen: false)
        .readJsonFile("savelater")
        .then((val) async {
      if (val == '') {
        var dataResponse = await getlocalSave();
        return dataResponse;
      } else {
        // ignore: avoid_print
        print('save later use read file');

        return jsonDecode(val.toString());
      }
    });
  }

  Future<dynamic> getItemSave() async {
    var uriItemSaveLater =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.saveLaterItem}');
    var resItemSaveLater = await http.get(uriItemSaveLater);
    if (resItemSaveLater.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItemSaveLater.body.toString());
    } else {
      throw Exception(resItemSaveLater.statusCode);
    }
  }

  Future<dynamic> getItemPriceSave() async {
    var uriPriceSavelater =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.saveLaterItemPrice}');
    var resPriceSavelater = await http.get(uriPriceSavelater);
    if (resPriceSavelater.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resPriceSavelater.body.toString());
    } else {
      throw Exception(resPriceSavelater.statusCode);
    }
  }

  // fetch data from api
  Future<String> fetchCartPageData() async {
    // get cart from endpoint
    try {
      var itemLocal = await readFileOrGetApi();
      var item = await getItem();
      var itemPirce = await getItemPrice();
      var chargeFee = await getChargeFee();

      var saveItemlocal = await readSaveFileOrGetApi();
      var saveItem = await getItemSave();
      var saveItemPrice = await getItemPriceSave();

      // push cart data to global varaible
      listItemLocal = (itemLocal as List)
          .map((e) => CartLocalStorageVm.fromJson(e))
          .toList();
      listItem = (item as List).map((e) => CartItemVm.fromJson(e)).toList();
      listItemPrice =
          (itemPirce as List).map((e) => CartItemPriceVm.fromJson(e)).toList();
      chargingFee =
          (chargeFee as List).map((e) => ChargingFeeVm.fromJson(e)).toList();

      // push save later data to global varaible
      listSaveItemLocal = (saveItemlocal as List)
          .map((e) => SaveLaterLocalStoreVm.fromJson(e))
          .toList();
      listSaveItem =
          (saveItem as List).map((e) => SaveLaterItemVm.fromJson(e)).toList();
      listSaveItemPrice = (saveItemPrice as List)
          .map((e) => SaveLaterItemPriceVm.fromJson(e))
          .toList();

      // map view item
      await mapViewCart();
      // map save later use
      await mapViewSaveLater();

      return "done";
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return "";
    }
  }

  // map for view item in cart
  Future<void> mapViewCart() async {
    if (listItemLocal.isNotEmpty) {
      viewItem = [];
      subTotal = 0.0;
      priceSaveing = 0.0;
      estimatedTotal = 0.0;
      for (var local in listItemLocal) {
        var item = listItem.firstWhere((e) => e.itemId == local.itemId);
        var price = listItemPrice.firstWhere((e) => e.itemId == local.itemId);

        // caculate total
        subTotal += (price.originalPrice * local.quantity);
        priceSaveing += ((price.originalPrice - price.price) * local.quantity);
        estimatedTotal += (price.price * local.quantity);

        var itemView = ViewCartVm(
            itemId: local.itemId,
            itemName: item.itemName,
            imageUrl: item.fileName,
            unitPrice: price.unitPrice,
            price: price.price,
            totalPrice: (price.price * local.quantity),
            unit: price.unit,
            originalPrice: price.originalPrice,
            totalOriginalPrice: (price.originalPrice * local.quantity),
            quantity: local.quantity);

        setState(() {
          viewItem.add(itemView);
        });
      }
    }
  }

  // map for view save later in cart
  Future<void> mapViewSaveLater() async {
    if (listSaveItemLocal.isNotEmpty) {
      for (var local in listSaveItemLocal) {
        var item = listSaveItem.firstWhere((e) => e.itemId == local.itemId);
        var price =
            listSaveItemPrice.firstWhere((e) => e.itemId == local.itemId);

        // map to view
        var itemView = ViewSaveLaterVm(
            itemId: local.itemId,
            itemName: item.itemName,
            imageUrl: item.fileName,
            unitPrice: price.unitPrice,
            price: price.price,
            totalPrice: (price.price * local.quantity),
            unit: price.unit,
            quantity: local.quantity);

        viewSaveLater.add(itemView);
      }
    }
  }

  // add more item
  void addMoreItemQty(String id) {
    setState(() {
      listItemLocal = listItemLocal.map((e) {
        if (e.itemId == id) {
          var motify = CartLocalStorageVm(
              itemId: e.itemId,
              quantity: e.quantity + 1,
              date: e.date,
              isSynced: false,
              isRemoved: false);
          return motify;
        } else {
          return e;
        }
      }).toList();

      mapViewCart();
    });
  }

  // sub item
  void subItemQty(String id) {
    setState(() {
      listItemLocal = listItemLocal.map((e) {
        if (e.itemId == id && e.quantity > 1) {
          var motify = CartLocalStorageVm(
              itemId: e.itemId,
              quantity: e.quantity - 1,
              date: e.date,
              isSynced: false,
              isRemoved: false);

          return motify;
        } else {
          return e;
        }
      }).toList();
      mapViewCart();
    });
  }

  @override
  void initState() {
    super.initState();
    // fetch all data from api
    temResponse = fetchCartPageData();
    // func listener
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          key: const Key('appbar'),
          toolbarHeight: 80,
          leadingWidth: 25,
          backgroundColor: Theme.of(context).primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 16, left: 14),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          title: searchInput(),
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
                child: FutureBuilder<String>(
                    key: const Key('future_builder'),
                    future: temResponse,
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
                        return Column(key: const Key('col_content'), children: [
                          // conten cart
                          Expanded(
                            child: ListView(
                              controller: controller,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                pickDelevery(),
                                const SizedBox(
                                  height: 10,
                                ),
                                headerCart("Cart", viewItem.length),
                                const SizedBox(
                                  height: 5,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: viewItem.length,
                                  itemBuilder: (context, index) => AddToCart(
                                    imgUrl: viewItem[index].imageUrl,
                                    name: viewItem[index].itemName,
                                    price: viewItem[index].price,
                                    unit: viewItem[index].unit,
                                    originalPrice:
                                        viewItem[index].originalPrice,
                                    unitPrice: viewItem[index].unitPrice,
                                    quantity: viewItem[index].quantity,
                                    isDiscount: (viewItem[index].originalPrice -
                                            viewItem[index].price) >
                                        0,
                                    onTapAdd: () =>
                                        addMoreItemQty(viewItem[index].itemId),
                                    onTapSub: () =>
                                        subItemQty(viewItem[index].itemId),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                headerCart("Save for later", 4),
                                const SizedBox(
                                  height: 5,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: viewSaveLater.length,
                                  itemBuilder: (context, index) =>
                                      SaveForLaterCart(
                                    imgUrl: viewSaveLater[index].imageUrl,
                                    name: viewSaveLater[index].itemName,
                                    price: viewSaveLater[index].price,
                                    unitPrice: viewSaveLater[index].unitPrice,
                                    unit: viewSaveLater[index].unit,
                                    quanity: viewSaveLater[index].quantity,
                                    totalPrice: viewSaveLater[index].totalPrice,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 190,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.02),
                                    blurRadius: 1,
                                    spreadRadius: 0,
                                    offset: Offset(
                                      0,
                                      1,
                                    ),
                                  ),
                                  BoxShadow(
                                    color: Color.fromRGBO(31, 35, 39, 0.212),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      ),
                                      Text(
                                        '\$$subTotal',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Saving',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[500]),
                                      ),
                                      Text(
                                        '\$$priceSaveing',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                for (var fee in chargingFee)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${fee.name} (${fee.minimumOrder})',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[500]),
                                        ),
                                        Text(
                                          '\$${fee.feeCharge}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]),
                                        )
                                      ],
                                    ),
                                  ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Estimated total',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        '\$$estimatedTotal',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[900]),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed('/review');
                                  },
                                  child: Container(
                                    width: Get.width * .95,
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: const Center(
                                        child: Text(
                                      'Continue to checkout',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]);
                      }
                    }))));
  }

  int indexs = 0;
  Padding pickDelevery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                blurRadius: 1,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  1,
                ),
              ),
              BoxShadow(
                color: Color.fromRGBO(31, 35, 39, 0.055),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  0,
                ),
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 5,
                ),
                chooseGetItem(
                    'https://cdn-icons-png.flaticon.com/128/10918/10918283.png',
                    'Shipping',
                    30),
                chooseGetItem(
                    'https://cdn-icons-png.flaticon.com/128/2481/2481797.png',
                    'Pickup',
                    30),
                chooseGetItem(
                    'https://cdn-icons-png.flaticon.com/128/17378/17378761.png',
                    'Delivery',
                    30),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        indexs = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: (indexs == index)
                            ? Theme.of(context).primaryColor
                            : null,
                        border: Border.all(
                            color: (indexs == index)
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 6}pm - ${index + 7}pm',
                          style: TextStyle(
                              fontSize: 15,
                              color: (indexs == index)
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column chooseGetItem(String url, String name, double width) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: Colors.blue[50]),
          child: Image.network(
            url,
            width: width,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        )
      ],
    );
  }

  Padding headerCart(String name, int item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                blurRadius: 1,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  1,
                ),
              ),
              BoxShadow(
                color: Color.fromRGBO(31, 35, 39, 0.055),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  0,
                ),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Text(
              'Item $item',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  // Search haeder
  Widget searchInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: CupertinoTextField(
        key: const Key('input'),
        keyboardType: TextInputType.none,
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 18),
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
      ),
    );
  }
}
