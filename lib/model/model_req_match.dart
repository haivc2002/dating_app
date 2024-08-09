class ModelReqMatch {
  int? idUser;
  int? keyMatch;

  ModelReqMatch({this.idUser, this.keyMatch});

  ModelReqMatch.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    keyMatch = json['keyMatch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['keyMatch'] = keyMatch;
    return data;
  }
}
