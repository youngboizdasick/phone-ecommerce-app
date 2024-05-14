class WorkflowState {
    String? id;
    String? code;
    String? name;
    bool? isSuccess;

    WorkflowState({this.id, this.code, this.name, this.isSuccess});

    WorkflowState.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        code = json["code"];
        name = json["name"];
        isSuccess = json["isSuccess"];
    }

    static List<WorkflowState> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => WorkflowState.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["code"] = code;
        _data["name"] = name;
        _data["isSuccess"] = isSuccess;
        return _data;
    }
}