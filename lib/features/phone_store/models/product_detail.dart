class ProductDetailModel {
  String? name;
  String? code;
  String? productId;
  int? listPriced;
  int? rateCount;
  int? soldCount;
  List<Images>? images;
  List<Attributes>? attributes;

  ProductDetailModel(
      {this.name,
      this.code,
      this.productId,
      this.listPriced,
      this.rateCount,
      this.soldCount,
      this.images,
      this.attributes,});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["productId"] is String) {
      productId = json["productId"];
    }
    if (json["listPriced"] is int) {
      listPriced = json["listPriced"];
    }
    if (json["rateCount"] is int) {
      rateCount = json["rateCount"];
    }
    if (json["soldCount"] is int) {
      soldCount = json["soldCount"];
    }
    if (json["images"] is List) {
      images = json["images"] == null
          ? null
          : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
    }
    if (json["attributes"] is List) {
      attributes = json["attributes"] == null
          ? null
          : (json["attributes"] as List)
              .map((e) => Attributes.fromJson(e))
              .toList();
    }
  }

  static List<ProductDetailModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductDetailModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["code"] = code;
    _data["productId"] = productId;
    _data["listPriced"] = listPriced;
    _data["rateCount"] = rateCount;
    _data["soldCount"] = soldCount;
    if (images != null) {
      _data["images"] = images?.map((e) => e.toJson()).toList();
    }
    if (attributes != null) {
      _data["attributes"] = attributes?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Attributes {
  String? fieldKey;
  String? fieldValue;
  int? fieldType;

  Attributes({this.fieldKey, this.fieldValue, this.fieldType});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json["fieldKey"] is String) {
      fieldKey = json["fieldKey"];
    }
    if (json["fieldValue"] is String) {
      fieldValue = json["fieldValue"];
    }
    if (json["fieldType"] is int) {
      fieldType = json["fieldType"];
    }
  }

  static List<Attributes> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Attributes.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fieldKey"] = fieldKey;
    _data["fieldValue"] = fieldValue;
    _data["fieldType"] = fieldType;
    return _data;
  }
}

class Images {
  String? imageUrl;

  Images({this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
  }

  static List<Images> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Images.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imageUrl"] = imageUrl;
    return _data;
  }
}
