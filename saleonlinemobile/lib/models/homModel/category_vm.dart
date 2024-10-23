class GetCategoryVm {
  late List<CategoryVm>? listCategory;

  GetCategoryVm({this.listCategory});

  factory GetCategoryVm.fromjson(List<dynamic> json) {
    return GetCategoryVm(
        listCategory: json.map((e) => CategoryVm.fromjson(e)).toList());
  }
}

class CategoryVm {
  late String id;
  late String name;

  CategoryVm({this.id = '', this.name = ''});

  factory CategoryVm.fromjson(Map<String, dynamic> json) {
    return CategoryVm(id: json['id'], name: json['name']);
  }
}
