class ModelListNomination {
  String? result;
  String? message;
  List<Nominations>? nominations;

  ModelListNomination({this.result, this.message, this.nominations});

  ModelListNomination.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['nominations'] != null) {
      nominations = <Nominations>[];
      json['nominations'].forEach((v) {
        nominations!.add(Nominations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (nominations != null) {
      data['nominations'] = nominations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nominations {
  int? idUser;
  List<ListImage>? listImage;
  Info? info;
  InfoMore? infoMore;

  Nominations({this.idUser, this.listImage, this.info, this.infoMore});

  Nominations.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    if (json['listImage'] != null) {
      listImage = <ListImage>[];
      json['listImage'].forEach((v) {
        listImage!.add(ListImage.fromJson(v));
      });
    }
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    infoMore = json['infoMore'] != null
        ? InfoMore.fromJson(json['infoMore'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    if (listImage != null) {
      data['listImage'] = listImage!.map((v) => v.toJson()).toList();
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (infoMore != null) {
      data['infoMore'] = infoMore!.toJson();
    }
    return data;
  }
}

class ListImage {
  int? id;
  int? idUser;
  String? image;

  ListImage({this.id, this.idUser, this.image});

  ListImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['image'] = image;
    return data;
  }
}

class Info {
  int? idUser;
  String? name;
  String? birthday;
  String? desiredState;
  String? word;
  String? academicLevel;
  double? lat;
  double? lon;
  String? describeYourself;
  String? gender;
  String? premiumState;

  Info(
      {this.idUser,
        this.name,
        this.birthday,
        this.desiredState,
        this.word,
        this.academicLevel,
        this.lat,
        this.lon,
        this.describeYourself,
        this.gender,
        this.premiumState});

  Info.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    name = json['name'];
    birthday = json['birthday'];
    desiredState = json['desiredState'];
    word = json['word'];
    academicLevel = json['academicLevel'];
    lat = json['lat'];
    lon = json['lon'];
    describeYourself = json['describeYourself'];
    gender = json['gender'];
    premiumState = json['premiumState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['name'] = name;
    data['birthday'] = birthday;
    data['desiredState'] = desiredState;
    data['word'] = word;
    data['academicLevel'] = academicLevel;
    data['lat'] = lat;
    data['lon'] = lon;
    data['describeYourself'] = describeYourself;
    data['gender'] = gender;
    data['premiumState'] = premiumState;
    return data;
  }
}

class InfoMore {
  int? idUser;
  int? height;
  String? wine;
  String? smoking;
  String? zodiac;
  String? religion;
  String? hometown;

  InfoMore(
      {this.idUser,
        this.height,
        this.wine,
        this.smoking,
        this.zodiac,
        this.religion,
        this.hometown});

  InfoMore.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    height = json['height'];
    wine = json['wine'];
    smoking = json['smoking'];
    zodiac = json['zodiac'];
    religion = json['religion'];
    hometown = json['hometown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['height'] = height;
    data['wine'] = wine;
    data['smoking'] = smoking;
    data['zodiac'] = zodiac;
    data['religion'] = religion;
    data['hometown'] = hometown;
    return data;
  }
}
