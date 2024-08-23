class ModelIsCheckNewState {
  int? idUser;
  int? keyMatch;

  ModelIsCheckNewState({this.idUser, this.keyMatch});

  ModelIsCheckNewState.fromJson(Map<String, dynamic> json) {
    idUser = json['id'];
    keyMatch = json['newState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['keyMatch'] = keyMatch;
    return data;
  }
}