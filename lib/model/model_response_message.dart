class ModelResponseMessage {
  String? result;
  List<Messages>? messages;

  ModelResponseMessage({this.result, this.messages});

  ModelResponseMessage.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  int? idUser;
  int? receiver;
  String? content;
  int? newState;

  Messages({this.id, this.idUser, this.receiver, this.content, this.newState});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    receiver = json['receiver'];
    content = json['content'];
    newState = json['newState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['receiver'] = receiver;
    data['content'] = content;
    data['newState'] = newState;
    return data;
  }
}
