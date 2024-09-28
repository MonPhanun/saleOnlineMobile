class ProductSearchVm {
  late String imgUrl;
  late bool isBestSeller;
  late bool isSponsored;
  late double price;
  late String priceCOZ;
  late String name;
  late int count;
  late bool isInCart;

  ProductSearchVm(
      {required this.imgUrl,
      required this.isBestSeller,
      required this.isSponsored,
      required this.price,
      required this.priceCOZ,
      required this.name,
      required this.count,
      required this.isInCart});
}
