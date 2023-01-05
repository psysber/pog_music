class SuggestPlayListsEntity {
  String? id;
  String? name;
  List<SuggestPlayLists>? data;

  SuggestPlayListsEntity({this.id, this.name, this.data});

  SuggestPlayListsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['records'] != null) {
      data = <SuggestPlayLists>[];
      json['records'].forEach((v) {
        data?.add(SuggestPlayLists.fromJson(v));
      });
    }
  }
}

class SuggestPlayLists {
  String? id;
  List<SuggestPlayListItem>? data;

  SuggestPlayLists({this.id, this.data});

  SuggestPlayLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['records'] != null) {
      data = <SuggestPlayListItem>[];
      json['records'].forEach((v) {
        data?.add(SuggestPlayListItem.fromJson(v));
      });
    }
  }
}

class SuggestPlayListItem {
  String? title;
  String? image;
  int? id;

  SuggestPlayListItem({this.title, this.image, this.id});

  SuggestPlayListItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
