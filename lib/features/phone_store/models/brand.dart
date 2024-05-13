class BrandModel {
  String? id;
  String? name;
  String? avatarLink;

  BrandModel({this.id, this.name, this.avatarLink});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    avatarLink = json["avatarLink"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["avatarLink"] = avatarLink;
    return data;
  }

  static List<BrandModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => BrandModel.fromJson(map)).toList();
  }
}
