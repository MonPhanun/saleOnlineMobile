import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/models/cartModel/cart_local_storage_vm.dart';
import 'package:saleonlinemobile/models/homModel/company_logo_vm.dart';
import 'package:saleonlinemobile/models/homModel/get_store_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/stateProvider/fileService/file_repo_controller.dart';
import 'package:saleonlinemobile/stateProvider/homeState/home_state_provider.dart';
import 'package:saleonlinemobile/views/searchDelegate/search_delegate.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({super.key, this.listStore, this.companyLogo});
  final ListGetStoreVm? listStore;
  final CompanyLogoVm? companyLogo;
  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  // declear variable
  bool colap = true;
  GetStoreVm primaryStore = GetStoreVm();
  List<GetStoreVm> listStore = [];
  CompanyLogoVm companyLogo = CompanyLogoVm();

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

  mapItem() async {
    var data = await readFileOrGetApi();
    var item =
        (data as List).map((e) => CartLocalStorageVm.fromJson(e)).toList();
    // ignore: use_build_context_synchronously
    await Provider.of<HomeStateProvider>(context, listen: false)
        .getItemInCart(item);
  }

  getLogo() {
    setState(() {
      if (widget.companyLogo != null) {
        companyLogo = widget.companyLogo!;
        Provider.of<HomeStateProvider>(context, listen: false)
            .setCompanyLogo(widget.companyLogo!);
      }

      if (widget.listStore != null) {
        for (var store in widget.listStore!.getStore!) {
          if (store.isPrimary) {
            primaryStore = store;
            Provider.of<HomeStateProvider>(context, listen: false)
                .setPrimayStore(store);
          } else {
            listStore.add(store);
          }
        }

        Provider.of<HomeStateProvider>(context, listen: false)
            .setListStore(listStore);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    mapItem();
    getLogo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStateProvider>(builder: (
      context,
      value,
      child,
    ) {
      return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  primaryStore.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/cart');
                  },
                  child: Column(
                    children: [
                      Badge(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryFixed,
                        label: Text('${value.lengthItemInCart}'),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4, right: 4),
                          child: FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      // const Text(
                      //   '\$0.00',
                      //   style: TextStyle(color: Colors.white, fontSize: 12),
                      // ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // func input search
            searchInput(context),
            const SizedBox(
              height: 5,
            ),
            // expend location
            ExpansionTile(
              minTileHeight: 40,
              dense: true,
              shape: const RoundedRectangleBorder(),
              collapsedShape: const RoundedRectangleBorder(),
              childrenPadding: const EdgeInsets.all(0),
              leading: colap
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: companyLogo.fileName,
                        height: 30,
                        width: 30,
                        placeholder: (context, url) => const CarouselShimmer(),
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
              title: colap
                  ? const Text(
                      'How do you want your item?',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  : const Center(
                      child: Text(
                        'How do you want your item?',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
              tilePadding: const EdgeInsets.all(0),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              onExpansionChanged: (value) {
                setState(() {
                  colap = !value;
                });
              },
              children: [
                const SizedBox(
                  height: 10,
                ),
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
                  height: 16,
                ),
                // location
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        primaryStore.address,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                ),

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: listStore.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          // location house
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.home_outlined,
                                      size: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listStore[index].name,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    Text(
                                      listStore[index].address,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  height: 3,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  // colape choose category to get item
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
          style: const TextStyle(fontSize: 12, color: Colors.white),
        )
      ],
    );
  }

  // Search haeder
  CupertinoTextField searchInput(BuildContext context) {
    return CupertinoTextField(
      keyboardType: TextInputType.none,
      padding: const EdgeInsets.symmetric(vertical: 8),
      placeholder: 'Search Walmart',
      readOnly: true,
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8, right: 4),
        child: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      style: const TextStyle(fontSize: 16),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          Icons.qr_code_scanner,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () {
        showSearch(context: context, delegate: SearchProductDelegate());
      },
    );
  }
}
