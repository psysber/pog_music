class ItemListEntity {
  String? id;
  String? imgUrl;
  String? name;
  String? singer;
  String? album;
  List<ItemListEntity>? data;

  ItemListEntity({this.id, this.imgUrl, this.name, this.singer, this.album});

  ItemListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['imgUrl'];
    name = json['name'];
    singer = json['singer'];
    album = json['album'];
  }

  ItemListEntity.fromList(List<dynamic> json) {
    data = <ItemListEntity>[];
    json.forEach((v) {
      data?.add(ItemListEntity.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['imgUrl'] = imgUrl;
    data['name'] = name;
    data['singer'] = singer;
    data['album'] = album;
    return data;
  }
}
