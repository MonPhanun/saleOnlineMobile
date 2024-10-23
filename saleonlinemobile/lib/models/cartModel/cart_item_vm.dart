class CartItemVm {
  late String categoryId;
  late String productId;
  late String itemId;
  late String itemName;
  late String fileName;

  CartItemVm(
      {this.categoryId = '',
      this.productId = '',
      this.itemId = '',
      this.itemName = '',
      this.fileName = ''});

  factory CartItemVm.fromJson(Map<String, dynamic> json) {
    return CartItemVm(
      categoryId: json['categoryId'],
      productId: json['productId'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      fileName: json['fileName'],
    );
  }
}
