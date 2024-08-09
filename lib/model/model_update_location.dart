class ModelUpdateLocation {
  int idUser;
  double lat, lon;

  ModelUpdateLocation({
    required this.idUser,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'lat': lat,
      'lon': lon,
    };
  }
  factory ModelUpdateLocation.fromJson(Map<String, dynamic> json) {
    return ModelUpdateLocation(
      idUser: json['idUser'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}