class CartProduct {
  String? productItemId;
  String? productItemName;
  String? productItemImageUrl;
  int? quantity;
  int? price;

  CartProduct(
      {this.productItemId,
      this.productItemName,
      this.productItemImageUrl,
      this.quantity,
      this.price});

  CartProduct.fromJson(Map<String, dynamic> json) {
    productItemId = json["productItemId"];
    productItemName = json["productItemName"];
    productItemImageUrl = json["productItemImageUrl"];
    quantity = json["quantity"];
    price = json["price"];
  }

  static List<CartProduct> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CartProduct.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["productItemId"] = productItemId;
    _data["productItemName"] = productItemName;
    _data["productItemImageUrl"] = productItemImageUrl;
    _data["quantity"] = quantity;
    _data["price"] = price;
    return _data;
  }
}
