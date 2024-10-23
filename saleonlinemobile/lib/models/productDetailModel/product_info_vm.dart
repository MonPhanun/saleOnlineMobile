import 'package:saleonlinemobile/models/productDetailModel/components_vm.dart';
import 'package:saleonlinemobile/models/productDetailModel/items_vm.dart';

class ProductInfoVm {
  late String productId;
  late String productName;
  late List<ComponentsVm>? components;
  late List<ItemsVm>? items;
  ProductInfoVm(
      {this.productId = '',
      this.productName = '',
      this.components,
      this.items});

  factory ProductInfoVm.fromJson(Map<String, dynamic> json) {
    return ProductInfoVm(
        productId: json['productId'],
        productName: json['productName'],
        components: (json['components'] as List)
            .map((e) => ComponentsVm.fromJson(e as Map<String, dynamic>))
            .toList(),
        items: (json['items'] as List)
            .map((e) => ItemsVm.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
