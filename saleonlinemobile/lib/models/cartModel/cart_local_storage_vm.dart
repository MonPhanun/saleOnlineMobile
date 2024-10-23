class CartLocalStorageVm {
  late String itemId;
  late int quantity;
  late String date;
  late bool isSynced;
  late bool isRemoved;

  CartLocalStorageVm(
      {this.itemId = '',
      this.quantity = 0,
      this.date = '',
      this.isSynced = false,
      this.isRemoved = false});

  factory CartLocalStorageVm.fromJson(Map<String, dynamic> json) {
    return CartLocalStorageVm(
      itemId: json['itemId'],
      quantity: json['quantity'],
      date: json['date'],
      isSynced: json['isSynced'],
      isRemoved: json['isRemoved'],
    );
  }
}
