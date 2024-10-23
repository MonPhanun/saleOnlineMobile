class GetItemImageVm {
  late List<ItemImageVm>? itemImage;

  GetItemImageVm({this.itemImage});

  factory GetItemImageVm.fromJson(List<dynamic> json) {
    return GetItemImageVm(
        itemImage: json
            .map((e) => ItemImageVm.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class ItemImageVm {
  late int imageTypeId;
  late String fileName;
  late bool isDefault;

  ItemImageVm(
      {this.imageTypeId = 0, this.fileName = '', this.isDefault = false});

  factory ItemImageVm.fromJson(Map<String, dynamic> json) {
    return ItemImageVm(
        imageTypeId: json['imageTypeId'],
        fileName: json['fileName'],
        isDefault: json['isDefault']);
  }
}
