import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:saleonlinemobile/services/headerApiSercice/header_api_service.dart';

class ViewMoreApiService {
  // ======== get item by category using search url ====>
  Future<dynamic> getMoreItemByCategory(String selectedCategory,
      String selectedStoreId, int productPerPage, int currentPage) async {
    var uriMoreItem = Uri.parse(
        '${dotenv.env['baseUrl']}Search/search/""/$selectedCategory/$selectedStoreId/$productPerPage/$currentPage');
    var resMoreItem =
        await http.get(uriMoreItem, headers: HeaderApiService.header());
    if (resMoreItem.statusCode == 200) {
      // return some value to trigger Furture Builder
      return jsonDecode(resMoreItem.body.toString());
    } else {
      throw Exception(resMoreItem.statusCode);
    }
  }
}
