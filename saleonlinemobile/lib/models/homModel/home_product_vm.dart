class ListHomeProductVm {
  late List<HomeProductVm>? listProduct;
  ListHomeProductVm({this.listProduct});

  factory ListHomeProductVm.fromjson(List<dynamic> json) {
    return ListHomeProductVm(
        listProduct: json.map((e) => HomeProductVm.fromjson(e)).toList());
  }
}

class HomeProductVm {
  late String categoryId;
  late String category;
  late String id;
  late String itemId;
  late String name;
  late String fileName;
  late double unitPrice;
  late double price;
  late String unit;

  HomeProductVm(
      {this.categoryId = '',
      this.category = '',
      this.id = '',
      this.itemId = '',
      this.name = '',
      this.fileName = '',
      this.unitPrice = 0.0,
      this.price = 0.0,
      this.unit = ''});

  factory HomeProductVm.fromjson(Map<String, dynamic> json) {
    return HomeProductVm(
        category: json['category'],
        categoryId: json['categoryId'],
        id: json['id'],
        itemId: json['itemId'],
        name: json['name'],
        fileName: json['fileName'],
        unitPrice: json['unitPrice'].toDouble(),
        price: json['price'].toDouble(),
        unit: json['unit']);
  }
}
