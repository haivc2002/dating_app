class ModelRequestSend {
  int? idUser;
  int? receiver;
  String? content;

  ModelRequestSend({this.idUser, this.receiver, this.content});

  ModelRequestSend.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    receiver = json['receiver'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['receiver'] = receiver;
    data['content'] = content;
    return data;
  }
}
