class DiscoveryEntity {
  String? name;
  String? api;
  List<DiscoveryEntity>? data;

  DiscoveryEntity({this.name, this.api});

  DiscoveryEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    api = json['api'];
  }

  DiscoveryEntity.fromList(List<dynamic> json) {
    data = <DiscoveryEntity>[];
    json.forEach((v) {
      data?.add(DiscoveryEntity.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['api'] = api;
    return data;
  }
}
