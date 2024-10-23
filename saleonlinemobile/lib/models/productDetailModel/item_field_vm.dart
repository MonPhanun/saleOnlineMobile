class GetIteFieldVm {
  late List<ItemFieldVm>? itemField;

  GetIteFieldVm({this.itemField});

  factory GetIteFieldVm.fromJson(List<dynamic> json) {
    return GetIteFieldVm(
        itemField: json
            .map((e) => ItemFieldVm.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class ItemFieldVm {
  late String fieldName;
  late String fieldValue;

  ItemFieldVm({this.fieldName = '', this.fieldValue = ''});

  factory ItemFieldVm.fromJson(Map<String, dynamic> json) {
    return ItemFieldVm(
      fieldName: json['fieldName'],
      fieldValue: json['fieldValue'],
    );
  }
}
