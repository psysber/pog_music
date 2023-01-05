class SearchSuggest {
  String? id;
  String? name;
  List<SearchSuggest>? data;

  SearchSuggest({this.id, this.name});

  SearchSuggest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  SearchSuggest.fromList(List<dynamic> json) {
    data = <SearchSuggest>[];
    json.forEach((v) {
      data?.add(SearchSuggest.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
