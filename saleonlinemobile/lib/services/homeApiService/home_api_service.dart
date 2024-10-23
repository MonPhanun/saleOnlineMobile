import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:saleonlinemobile/services/headerApiSercice/header_api_service.dart';

class HomeApiService {
  // ======== Store ====>
  static Future<dynamic> getStore(String tenantId) async {
    var uriStore =
        Uri.parse('${dotenv.env['baseUrl']}Location/store/$tenantId');
    var resStore = await http.get(uriStore, headers: HeaderApiService.header());
    if (resStore.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resStore.body.toString());
    } else {
      throw Exception(resStore.statusCode);
    }
  }

  // ======== company logo ====>
  static Future<dynamic> getCompanyLogo(String tenantId) async {
    var uriCompanyLogo =
        Uri.parse('${dotenv.env['baseUrl']}CompanySetup/logo/$tenantId');
    var resCompanyLogo =
        await http.get(uriCompanyLogo, headers: HeaderApiService.header());
    if (resCompanyLogo.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCompanyLogo.body.toString());
    } else {
      throw Exception(resCompanyLogo.statusCode);
    }
  }

  // ======== category ====>
  static Future<dynamic> getCategory(String tenantId) async {
    var uriCategory =
        Uri.parse('${dotenv.env['baseUrl']}Search/category/$tenantId');
    var resCategory =
        await http.get(uriCategory, headers: HeaderApiService.header());
    if (resCategory.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resCategory.body.toString());
    } else {
      throw Exception(resCategory.statusCode);
    }
  }

  // ======== category ====>
  static Future<dynamic> getHomeItem(String tenantId) async {
    var uriHomeItem =
        Uri.parse('${dotenv.env['baseUrl']}SaleOnline/homepage/$tenantId');
    var resHomeItem =
        await http.get(uriHomeItem, headers: HeaderApiService.header());
    if (resHomeItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resHomeItem.body.toString());
    } else {
      throw Exception(resHomeItem.statusCode);
    }
  }

  // ======== search ====>
  static Future<dynamic> searchProduct(
      String searchQuery,
      String seletedCategory,
      String selectedStoreId,
      String productPerPage,
      String currentPage) async {
    var uriHomeItem = Uri.parse(
        '${dotenv.env['baseUrl']}search/$searchQuery/$seletedCategory/$selectedStoreId/$productPerPage/$currentPage');
    var resHomeItem =
        await http.get(uriHomeItem, headers: HeaderApiService.header());
    if (resHomeItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resHomeItem.body.toString());
    } else {
      throw Exception(resHomeItem.statusCode);
    }
  }
}
