class ModelResUpdateLocation {
  String? result;
  String? message;

  ModelResUpdateLocation({this.result, this.message});

  ModelResUpdateLocation.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    return data;
  }
}
