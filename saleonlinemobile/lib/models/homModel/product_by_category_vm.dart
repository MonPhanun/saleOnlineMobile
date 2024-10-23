import 'package:saleonlinemobile/models/homModel/category_vm.dart';
import 'package:saleonlinemobile/models/homModel/home_product_vm.dart';

class ProductByCategoryVm {
  late CategoryVm? category;
  late List<HomeProductVm>? listProduct;

  ProductByCategoryVm({this.category, this.listProduct});
}
