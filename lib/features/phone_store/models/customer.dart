class CustomerModel {
  String? id;
  String? name;
  String? email;
  int? birthday;
  int? totalPrice;
  List<CustomerAddresses>? customerAddresses;
  List<CustomerPhones>? customerPhones;

  CustomerModel(
      {this.id,
      this.name,
      this.email,
      this.birthday,
      this.totalPrice,
      this.customerAddresses,
      this.customerPhones});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? '';
    name = json["name"] ?? '';
    email = json["email"] ?? '';
    birthday = json["birthday"] ?? 0;
    totalPrice = json["totalPrice"] ?? 0;
    if (json["customerAddresses"] is List) {
      customerAddresses = json["customerAddresses"] == null
          ? null
          : (json["customerAddresses"] as List)
              .map((e) => CustomerAddresses.fromJson(e))
              .toList();
    }
    if (json["customerPhones"] is List) {
      customerPhones = json["customerPhones"] == null
          ? null
          : (json["customerPhones"] as List)
              .map((e) => CustomerPhones.fromJson(e))
              .toList();
    }
  }

  static List<CustomerModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CustomerModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["birthday"] = birthday;
    _data["totalPrice"] = totalPrice;
    if (customerAddresses != null) {
      _data["customerAddresses"] =
          customerAddresses?.map((e) => e.toJson()).toList();
    }
    if (customerPhones != null) {
      _data["customerPhones"] = customerPhones?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CustomerPhones {
  String? id;
  String? phoneNumber;
  bool? isPrimary;

  CustomerPhones({this.id, this.phoneNumber, this.isPrimary});

  CustomerPhones.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if (json["isPrimary"] is bool) {
      isPrimary = json["isPrimary"];
    }
  }

  static List<CustomerPhones> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CustomerPhones.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["phoneNumber"] = phoneNumber;
    _data["isPrimary"] = isPrimary;
    return _data;
  }
}

class CustomerAddresses {
  String? id;
  String? customerId;
  String? address;
  bool? isPrimary;
  int? lat;
  int? lng;
  Province? province;
  District? district;
  Ward? ward;

  CustomerAddresses(
      {this.id,
      this.customerId,
      this.address,
      this.isPrimary,
      this.lat,
      this.lng,
      this.province,
      this.district,
      this.ward});

  CustomerAddresses.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["customerId"] is String) {
      customerId = json["customerId"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["isPrimary"] is bool) {
      isPrimary = json["isPrimary"];
    }
    if (json["lat"] is int) {
      lat = json["lat"];
    }
    if (json["lng"] is int) {
      lng = json["lng"];
    }
    if (json["province"] is Map) {
      province =
          json["province"] == null ? null : Province.fromJson(json["province"]);
    }
    if (json["district"] is Map) {
      district =
          json["district"] == null ? null : District.fromJson(json["district"]);
    }
    if (json["ward"] is Map) {
      ward = json["ward"] == null ? null : Ward.fromJson(json["ward"]);
    }
  }

  static List<CustomerAddresses> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CustomerAddresses.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["customerId"] = customerId;
    _data["address"] = address;
    _data["isPrimary"] = isPrimary;
    _data["lat"] = lat;
    _data["lng"] = lng;
    if (province != null) {
      _data["province"] = province?.toJson();
    }
    if (district != null) {
      _data["district"] = district?.toJson();
    }
    if (ward != null) {
      _data["ward"] = ward?.toJson();
    }
    return _data;
  }
}

class Ward {
  int? code;
  String? name;

  Ward({this.code, this.name});

  Ward.fromJson(Map<String, dynamic> json) {
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  static List<Ward> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Ward.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["name"] = name;
    return _data;
  }
}

class District {
  int? code;
  String? name;

  District({this.code, this.name});

  District.fromJson(Map<String, dynamic> json) {
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  static List<District> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => District.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["name"] = name;
    return _data;
  }
}

class Province {
  int? code;
  String? name;

  Province({this.code, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  static List<Province> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Province.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["name"] = name;
    return _data;
  }
}
