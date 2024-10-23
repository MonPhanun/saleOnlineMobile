class SaveLaterItemPriceVm {
  late String itemId;
  late double unitPrice;
  late double price;
  late String unit;
  late double originalPrice;

  SaveLaterItemPriceVm({
    this.itemId = '',
    this.unitPrice = 0.0,
    this.price = 0.0,
    this.unit = '',
    this.originalPrice = 0.0,
  });

  factory SaveLaterItemPriceVm.fromJson(Map<String, dynamic> json) {
    return SaveLaterItemPriceVm(
      itemId: json['itemId'],
      unitPrice: json['unitPrice'].toDouble(),
      price: json['price'].toDouble(),
      unit: json['unit'],
      originalPrice: json['originalPrice'].toDouble(),
    );
  }
}
