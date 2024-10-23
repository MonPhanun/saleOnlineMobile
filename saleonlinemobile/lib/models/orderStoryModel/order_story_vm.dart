class OrderStoryVm {
  late String itemId;
  late String itemName;
  late String imageUrl;
  late double unitPrice;
  late double price;
  late double totalPrice;
  late String unit;
  late double originalPrice;
  late double totalOriginalPrice;
  late int quantity;

  OrderStoryVm(
      {this.itemId = '',
      this.itemName = '',
      this.imageUrl = '',
      this.unitPrice = 0.0,
      this.price = 0.0,
      this.totalPrice = 0.0,
      this.unit = '',
      this.originalPrice = 0.0,
      this.totalOriginalPrice = 0.0,
      this.quantity = 0});

  factory OrderStoryVm.fromjson(Map<String, dynamic> json) {
    return OrderStoryVm(
      itemId: json['itemId'],
      itemName: json['itemName'],
      imageUrl: json['imageUrl'],
      unitPrice: json['unitPrice'].toDouble(),
      price: json['price'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
      unit: json['unit'],
      originalPrice: json['originalPrice'].toDouble(),
      totalOriginalPrice: json['totalOriginalPrice'].toDouble(),
      quantity: json['quantity'],
    );
  }
}
