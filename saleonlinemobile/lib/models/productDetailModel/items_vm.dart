class ItemsVm {
  late String itemId;
  late bool isDefault;
  late List<String>? itemValues;

  ItemsVm({this.itemId = '', this.isDefault = false, this.itemValues});

  factory ItemsVm.fromJson(Map<String, dynamic> json) {
    return ItemsVm(
        itemId: json['itemId'],
        isDefault: json['isDefault'],
        itemValues: (json['componentValues'] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }
}
