class SaveLaterItemVm {
  late String categoryId;
  late String productId;
  late String itemId;
  late String itemName;
  late String fileName;

  SaveLaterItemVm(
      {this.categoryId = '',
      this.productId = '',
      this.itemId = '',
      this.itemName = '',
      this.fileName = ''});

  factory SaveLaterItemVm.fromJson(Map<String, dynamic> json) {
    return SaveLaterItemVm(
      categoryId: json['categoryId'],
      productId: json['productId'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      fileName: json['fileName'],
    );
  }
}
