class SearchSuggestionVm {
  late String imgUrl;
  late String name;

  SearchSuggestionVm({this.imgUrl = '', this.name = ''});

  factory SearchSuggestionVm.fromjson(Map<String, dynamic> json) {
    return SearchSuggestionVm(imgUrl: json['imgUrl'], name: json['name']);
  }
}
