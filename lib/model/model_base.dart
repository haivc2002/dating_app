class ModelBase {
  String? result;
  String? message;
  int? idUser;

  ModelBase({this.result, this.message, this.idUser});

  ModelBase.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    idUser = json['idUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['idUser'] = idUser;
    return data;
  }
}
