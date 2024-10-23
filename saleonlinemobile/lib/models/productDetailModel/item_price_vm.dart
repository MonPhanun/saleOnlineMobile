class ItemPriceVm {
  late double price;

  ItemPriceVm({this.price = 0.0});

  factory ItemPriceVm.fromJson(Map<String, dynamic> json) {
    return ItemPriceVm(price: json['price'].toDouble());
  }
}
