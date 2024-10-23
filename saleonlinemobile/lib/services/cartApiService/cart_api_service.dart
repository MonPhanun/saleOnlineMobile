import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:saleonlinemobile/services/headerApiSercice/header_api_service.dart';

class CartApiService {
  // ======== cart ====>

  // ======== sync cart when something has been edit ====>
  static Future<dynamic> callbackSyncCart(dynamic body) async {
    var uriItem = Uri.parse('${dotenv.env['baseUrl']}Cart/synccart');
    var resItem = await http.post(uriItem,
        headers: HeaderApiService.header(), body: body);
    if (resItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItem.body.toString());
    } else {
      throw Exception(resItem.statusCode);
    }
  }

  // ======== get Item save later use in cart ====>
  static Future<dynamic> getItemInCart(String tenantId) async {
    var uriItem = Uri.parse('${dotenv.env['baseUrl']}Cart/cartitem/$tenantId');
    var resItem = await http.get(uriItem, headers: HeaderApiService.header());
    if (resItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItem.body.toString());
    } else {
      throw Exception(resItem.statusCode);
    }
  }

  static Future<dynamic> getItem(String tenantId, String strItemId) async {
    var uriItem = Uri.parse(
        '${dotenv.env['baseUrl']}ProductSetup/cartitemlist/$tenantId?itemIds=$strItemId');
    var resItem = await http.get(uriItem, headers: HeaderApiService.header());
    if (resItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItem.body.toString());
    } else {
      throw Exception(resItem.statusCode);
    }
  }

  static Future<dynamic> getItemPrice(
      String tenantId, String strItemIds) async {
    var uriPrice = Uri.parse(
        '${dotenv.env['baseUrl']}PriceSetup/pricelist/$tenantId?items=$strItemIds');
    var resPrice = await http.get(uriPrice, headers: HeaderApiService.header());
    if (resPrice.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resPrice.body.toString());
    } else {
      throw Exception(resPrice.statusCode);
    }
  }

  static Future<dynamic> getChargeFee(
      String tenantId, String totalPrice) async {
    var uriChargeFee = Uri.parse(
        '${dotenv.env['baseUrl']}PriceSetup/charging/$tenantId?itemIds=$totalPrice');
    var resChargeGee =
        await http.get(uriChargeFee, headers: HeaderApiService.header());
    if (resChargeGee.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resChargeGee.body.toString());
    } else {
      throw Exception(resChargeGee.statusCode);
    }
  }

  // ====== save later use ===>

  // ======== get Item save later use in cart ====>
  static Future<dynamic> getItemSaveInCart(String tenantId) async {
    var uriItem =
        Uri.parse('${dotenv.env['baseUrl']}Cart/savelateritem/$tenantId');
    var resItem = await http.get(uriItem, headers: HeaderApiService.header());
    if (resItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItem.body.toString());
    } else {
      throw Exception(resItem.statusCode);
    }
  }

  // ======== get Item in cart ====>
  static Future<dynamic> getItemSave(String tenantId, String strItemIds) async {
    var uriItemSaveLater = Uri.parse(
        '${dotenv.env['baseUrl']}ProductSetup/cartitemlist/$tenantId?items=$strItemIds');
    var resItemSaveLater =
        await http.get(uriItemSaveLater, headers: HeaderApiService.header());
    if (resItemSaveLater.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItemSaveLater.body.toString());
    } else {
      throw Exception(resItemSaveLater.statusCode);
    }
  }

  // ======== sync save seter use when something has been edit ====>
  static Future<dynamic> callbackSyncSaveLaterUse(dynamic body) async {
    var uriItem = Uri.parse('${dotenv.env['baseUrl']}Cart/syncsavelateruse');
    var resItem = await http.post(uriItem,
        headers: HeaderApiService.header(), body: body);
    if (resItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resItem.body.toString());
    } else {
      throw Exception(resItem.statusCode);
    }
  }

  static Future<dynamic> getItemPriceSave(
      String tenantId, String strItemIds) async {
    var uriPriceSavelater = Uri.parse(
        '${dotenv.env['baseUrl']}PriceSetup/pricelist/$tenantId?itemIds=$strItemIds');
    var resPriceSavelater =
        await http.get(uriPriceSavelater, headers: HeaderApiService.header());
    if (resPriceSavelater.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resPriceSavelater.body.toString());
    } else {
      throw Exception(resPriceSavelater.statusCode);
    }
  }
}
