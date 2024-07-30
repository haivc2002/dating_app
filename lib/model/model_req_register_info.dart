class ModelReqRegisterInfo {
  int? idUser;
  String? name;
  String? birthday;
  String? desiredState;
  double? lat;
  double? lon;
  String? gender;

  ModelReqRegisterInfo({this.lon, this.name, this.birthday, this.desiredState, this.gender, this.idUser, this.lat});

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'name': name,
      'birthday': birthday,
      'desiredState': desiredState,
      'lat': lat,
      'lon': lon,
      'gender': gender
    };
  }
}