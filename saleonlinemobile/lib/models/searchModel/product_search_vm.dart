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
      {this.imgUrl = '',
      this.isBestSeller = false,
      this.isSponsored = false,
      this.price = 0.00,
      this.priceCOZ = '',
      this.name = '',
      this.count = 0,
      this.isInCart = false});
}
