class ProductBasicModel {
  String? name;
  String? brandId;
  String? code;
  String? avatarLink;
  int? listedPrice;

  ProductBasicModel({
    this.name,
    this.brandId,
    this.code,
    this.avatarLink,
    this.listedPrice,
  });

  ProductBasicModel.fromJson(Map<String, dynamic> json) {
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
  }

  static List<ProductBasicModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductBasicModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["brandId"] = brandId;
    _data["code"] = code;
    _data["avatarLink"] = avatarLink;
    _data["listedPrice"] = listedPrice;
    return _data;
  }
}
