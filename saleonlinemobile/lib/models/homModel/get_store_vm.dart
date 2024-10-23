class ListGetStoreVm {
  late List<GetStoreVm>? getStore;

  ListGetStoreVm({this.getStore});

  factory ListGetStoreVm.fromjson(List<dynamic> json) {
    return ListGetStoreVm(
        getStore: json.map((e) => GetStoreVm.fromjson(e)).toList());
  }
}

class GetStoreVm {
  late String id;
  late String name;
  late String address;
  late bool isPrimary;

  GetStoreVm(
      {this.id = '',
      this.name = '',
      this.address = '',
      this.isPrimary = false});

  factory GetStoreVm.fromjson(Map<String, dynamic> json) {
    return GetStoreVm(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        isPrimary: json['isPrimary']);
  }
}
