import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:saleonlinemobile/models/searchModel/response_search_vm.dart';
import 'package:saleonlinemobile/models/searchSuggestionModel/search_suggestion_vm.dart';
import 'package:saleonlinemobile/services/end_point.service.dart';
import 'package:saleonlinemobile/views/shares/searchCart/product_search_cart.dart';
import 'package:saleonlinemobile/views/shimmerShare/carouselShimmer/carousel_shimmer.dart';
import 'package:http/http.dart' as http;

class SearchProductDelegate extends SearchDelegate {
  List<SearchSuggestionVm> suggestion = [];
  Future<String>? temSegges;
  // product responce
  List<ResponseSearchVm> productRes = [];
  Future<String>? temProductRes;

  Future<dynamic> getSuggestion() async {
    var uriProduct =
        Uri.parse('${dotenv.env['baseUrl']}${EndPoint.suggestion}');
    var resProduct = await http.get(uriProduct);
    if (resProduct.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resProduct.body.toString());
    } else {
      throw Exception(resProduct.statusCode);
    }
  }

  Future<String>? fetchSuggestion() async {
    try {
      var suggest = await getSuggestion();

      suggestion =
          (suggest as List).map((e) => SearchSuggestionVm.fromjson(e)).toList();

      return "done";
    } catch (e) {
      throw Exception(e);
    }
  }

  // product responce
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

  Future<String>? fetchProduct() async {
    try {
      var product = await getProduct();
      productRes =
          (product as List).map((e) => ResponseSearchVm.fromjson(e)).toList();

      return "done";
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    //  buildActions
    return [
      InkWell(
        onTap: () {
          showResults(context);
        },
        child: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      const SizedBox(
        width: 15,
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // buildLeading
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    temProductRes = fetchProduct();
    //  buildResults
    return FutureBuilder<String>(
        key: const Key("future_builder"),
        future: temProductRes,
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
                itemCount: productRes.length,
                itemBuilder: (context, index) => Container(
                      height: 290,
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
                      ),
                    ));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    temSegges = fetchSuggestion();
    //  buildSuggestions
    return FutureBuilder<String>(
        key: const Key("future_builder"),
        future: temSegges,
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
                itemCount: suggestion.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          leading: ClipOval(
                            child: CachedNetworkImage(
                              height: 40,
                              width: 40,
                              imageUrl: suggestion[index].imgUrl,
                              placeholder: (context, url) =>
                                  const CarouselShimmer(),
                            ),
                          ),
                          title: Text(
                            suggestion[index].name,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            height: 0.1,
                            color: Color.fromARGB(146, 224, 224, 224),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    ));
          }
        });
  }
}
