class ProductItemModel {
  String? id;
  String? name;
  String? code;
  String? productId;
  int? listPriced;
  int? rateCount;
  int? soldCount;
  List<Images>? images;
  List<ProductItemAttributes>? productItemAttributes;

  ProductItemModel(
      {this.id,
      this.name,
      this.code,
      this.productId,
      this.listPriced,
      this.rateCount,
      this.soldCount,
      this.images,
      this.productItemAttributes});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    code = json["code"];
    productId = json["productId"];
    listPriced = json["listPriced"];
    rateCount = json["rateCount"];
    soldCount = json["soldCount"];
    images = json["images"] == null
        ? null
        : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
    productItemAttributes = json["productItemAttributes"] == null
        ? null
        : (json["productItemAttributes"] as List)
            .map((e) => ProductItemAttributes.fromJson(e))
            .toList();
  }

  static List<ProductItemModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductItemModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["code"] = code;
    _data["productId"] = productId;
    _data["listPriced"] = listPriced;
    _data["rateCount"] = rateCount;
    _data["soldCount"] = soldCount;
    if (images != null) {
      _data["images"] = images?.map((e) => e.toJson()).toList();
    }
    if (productItemAttributes != null) {
      _data["productItemAttributes"] =
          productItemAttributes?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ProductItemAttributes {
  String? fieldKey;
  String? fieldValue;
  int? fieldType;

  ProductItemAttributes({this.fieldKey, this.fieldValue, this.fieldType});

  ProductItemAttributes.fromJson(Map<String, dynamic> json) {
    fieldKey = json["fieldKey"];
    fieldValue = json["fieldValue"];
    fieldType = json["fieldType"];
  }

  static List<ProductItemAttributes> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProductItemAttributes.fromJson(map)).toList();
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
    imageUrl = json["imageUrl"];
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
