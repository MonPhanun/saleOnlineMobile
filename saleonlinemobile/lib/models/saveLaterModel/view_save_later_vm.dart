class ViewSaveLaterVm {
  late String itemId;
  late String itemName;
  late String imageUrl;
  late double unitPrice;
  late double price;
  late double totalPrice;
  late String unit;

  late int quantity;

  ViewSaveLaterVm(
      {this.itemId = '',
      this.itemName = '',
      this.imageUrl = '',
      this.unitPrice = 0.0,
      this.price = 0.0,
      this.totalPrice = 0.0,
      this.unit = '',
      this.quantity = 0});
}
