class ResponseSearchVm {
  late String categoryId;
  late String category;
  late String id;
  late String itemId;
  late String name;
  late String fileName;
  late double unitPrice;
  late double price;
  late String unit;

  ResponseSearchVm(
      {this.categoryId = '',
      this.category = '',
      this.id = '',
      this.itemId = '',
      this.name = '',
      this.fileName = '',
      this.unitPrice = 0.0,
      this.price = 0.0,
      this.unit = ''});

  factory ResponseSearchVm.fromjson(Map<String, dynamic> json) {
    return ResponseSearchVm(
        categoryId: json['categoryId'],
        category: json['category'],
        id: json['id'],
        itemId: json['itemId'],
        name: json['name'],
        fileName: json['fileName'],
        unitPrice: json['unitPrice'],
        price: json['price'],
        unit: json['unit']);
  }
}
