class StoreCategoryVm {
  late String categoryId;
  late String store;
  late String category;

  StoreCategoryVm({this.categoryId = '', this.store = '', this.category = ''});

  factory StoreCategoryVm.fromJson(Map<String, dynamic> json) {
    return StoreCategoryVm(
        categoryId: json['categoryId'],
        store: json['store'],
        category: json['category']);
  }
}
