class ProductCartVM {
  late String imgUrl;
  late String name;
  late double price;
  late String currency;
  late double localPrice;
  late String? dsc;

  ProductCartVM(
      {required this.imgUrl,
      required this.name,
      required this.price,
      required this.currency,
      required this.localPrice,
      this.dsc});
}
