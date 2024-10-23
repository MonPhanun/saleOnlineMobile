class ItemQuantityVm {
  late int qty;

  ItemQuantityVm({this.qty = 0});

  factory ItemQuantityVm.fromJson(Map<String, dynamic> json) {
    return ItemQuantityVm(qty: json['quantity']);
  }
}
