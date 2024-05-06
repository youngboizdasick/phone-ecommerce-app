class ProductIntroModel {
  String? id;
  String? name;
  String? brandId;
  String? code;
  String? avatarLink;
  int? listedPrice;
  bool? isPublic;

  ProductIntroModel(
      {this.id,
      this.name,
      this.brandId,
      this.code,
      this.avatarLink,
      this.listedPrice,
      this.isPublic});

  ProductIntroModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["brandId"] is String) {
      brandId = json["brandId"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["avatarLink"] is String) {
      avatarLink = json["avatarLink"];
    }
    if (json["listedPrice"] is int) {
      listedPrice = json["listedPrice"];
    }
    if (json["isPublic"] is bool) {
      isPublic = json["isPublic"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["brandId"] = brandId;
    _data["code"] = code;
    _data["avatarLink"] = avatarLink;
    _data["listedPrice"] = listedPrice;
    _data["isPublic"] = isPublic;
    return _data;
  }
}
