class CartModelApi {
  String? id;
  int? totalPrice;
  CustomerAddress? customerAddress;
  CustomerPhone? customerPhone;
  List<CartProducts>? cartProducts;

  CartModelApi(
      {this.id,
      this.totalPrice,
      this.customerAddress,
      this.customerPhone,
      this.cartProducts});

  CartModelApi.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    totalPrice = json["totalPrice"];
    customerAddress = json["customerAddress"] == null
        ? null
        : CustomerAddress.fromJson(json["customerAddress"]);
    customerPhone = json["customerPhone"] == null
        ? null
        : CustomerPhone.fromJson(json["customerPhone"]);
    cartProducts = json["cartProducts"] == null
        ? null
        : (json["cartProducts"] as List)
            .map((e) => CartProducts.fromJson(e))
            .toList();
  }

  static List<CartModelApi> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CartModelApi.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["totalPrice"] = totalPrice;
    if (customerAddress != null) {
      _data["customerAddress"] = customerAddress?.toJson();
    }
    if (customerPhone != null) {
      _data["customerPhone"] = customerPhone?.toJson();
    }
    if (cartProducts != null) {
      _data["cartProducts"] = cartProducts?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CartProducts {
  String? cartId;
  String? productItemId;
  String? productItemImageUrl;
  int? quantity;
  int? price;
  bool? isChoosed;

  CartProducts(
      {this.cartId,
      this.productItemId,
      this.productItemImageUrl,
      this.quantity,
      this.price,
      this.isChoosed = false});

  CartProducts.fromJson(Map<String, dynamic> json) {
    cartId = json["cartId"];
    productItemId = json["productItemId"];
    productItemImageUrl = json["productItemImageUrl"];
    quantity = json["quantity"];
    price = json["price"];
  }

  static List<CartProducts> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CartProducts.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["cartId"] = cartId;
    _data["productItemId"] = productItemId;
    _data["productItemImageUrl"] = productItemImageUrl;
    _data["quantity"] = quantity;
    _data["price"] = price;
    return _data;
  }
}

class CustomerPhone {
  String? id;
  String? phoneNumber;
  bool? isPrimary;

  CustomerPhone({this.id, this.phoneNumber, this.isPrimary});

  CustomerPhone.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    phoneNumber = json["phoneNumber"];
    isPrimary = json["isPrimary"];
  }

  static List<CustomerPhone> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CustomerPhone.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["phoneNumber"] = phoneNumber;
    _data["isPrimary"] = isPrimary;
    return _data;
  }
}

class CustomerAddress {
  String? id;
  String? address;
  bool? isPrimary;
  int? wardCode;
  int? districtCode;
  int? provinceCode;

  CustomerAddress(
      {this.id,
      this.address,
      this.isPrimary,
      this.wardCode,
      this.districtCode,
      this.provinceCode});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    address = json["address"];
    isPrimary = json["isPrimary"];
    wardCode = json["wardCode"];
    districtCode = json["districtCode"];
    provinceCode = json["provinceCode"];
  }

  static List<CustomerAddress> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CustomerAddress.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["address"] = address;
    _data["isPrimary"] = isPrimary;
    _data["wardCode"] = wardCode;
    _data["districtCode"] = districtCode;
    _data["provinceCode"] = provinceCode;
    return _data;
  }
}
