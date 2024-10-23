import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:saleonlinemobile/services/headerApiSercice/header_api_service.dart';

class ProductDetailApiService {
  // ======== get category ====>
  Future<dynamic> getCategory(String tenantId, String priductId) async {
    var uriCategory = Uri.parse(
        '${dotenv.env['baseUrl']}ProductSetup/storecategory/$tenantId/$priductId');
    var resCategory =
        await http.get(uriCategory, headers: HeaderApiService.header());
    if (resCategory.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCategory.body.toString());
    } else {
      throw Exception(resCategory.statusCode);
    }
  }

  // ======== get product info ====>
  Future<dynamic> getProductInfo(String tenantId, String priductId) async {
    var uriProduct = Uri.parse(
        '${dotenv.env['baseUrl']}ProductSetup/product/$tenantId/$priductId');
    var resProduct =
        await http.get(uriProduct, headers: HeaderApiService.header());
    if (resProduct.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resProduct.body.toString());
    } else {
      throw Exception(resProduct.statusCode);
    }
  }

  // ======== get item price ====>
  Future<dynamic> getItemPrice(String tenantId, String itemId) async {
    var uriPrice =
        Uri.parse('${dotenv.env['baseUrl']}PriceSetup/price/$tenantId/$itemId');
    var resPrice = await http.get(uriPrice, headers: HeaderApiService.header());
    if (resPrice.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resPrice.body.toString());
    } else {
      throw Exception(resPrice.statusCode);
    }
  }

  // ======== get item quantity ====>
  Future<dynamic> getItemQty(String tenantId, String itemId) async {
    var uriQty =
        Uri.parse('${dotenv.env['baseUrl']}Stock/quantity/$tenantId/$itemId');
    var resQty = await http.get(uriQty, headers: HeaderApiService.header());
    if (resQty.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resQty.body.toString());
    } else {
      throw Exception(resQty.statusCode);
    }
  }

  // ======== get item image ====>
  Future<dynamic> getImage(
      String tenantId, String productId, String itemId) async {
    var uriImg = Uri.parse(
        '${dotenv.env['baseUrl']}ProductSetup/image/$tenantId/$productId/$itemId');
    var resImg = await http.get(uriImg, headers: HeaderApiService.header());
    if (resImg.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resImg.body.toString());
    } else {
      throw Exception(resImg.statusCode);
    }
  }

  // ======== get item field ====>
  Future<dynamic> getItemField(String tenantId, String itemId) async {
    var uriField = Uri.parse(
        '${dotenv.env['baseUrl']}ProductSetup/itemfield/$tenantId/$itemId');
    var resField = await http.get(uriField, headers: HeaderApiService.header());
    if (resField.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resField.body.toString());
    } else {
      throw Exception(resField.statusCode);
    }
  }
}
