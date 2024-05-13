class AddressModel {
  int? code;
  String? name;

  AddressModel({this.code, this.name});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  static List<AddressModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AddressModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["name"] = name;
    return _data;
  }
}
