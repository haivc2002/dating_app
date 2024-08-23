class ModelOutsideViewMessage {
  String? result;
  List<Conversations>? conversations;

  ModelOutsideViewMessage({this.result, this.conversations});

  ModelOutsideViewMessage.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(Conversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (conversations != null) {
      data['conversations'] =
          conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversations {
  int? idUser;
  LatestMessage? latestMessage;
  Info? info;
  InfoMore? infoMore;
  List<ListImage>? listImage;

  Conversations(
      {this.idUser,
        this.latestMessage,
        this.info,
        this.infoMore,
        this.listImage});

  Conversations.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    latestMessage = json['latestMessage'] != null
        ? LatestMessage.fromJson(json['latestMessage'])
        : null;
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    infoMore = json['infoMore'] != null
        ? InfoMore.fromJson(json['infoMore'])
        : null;
    if (json['listImage'] != null) {
      listImage = <ListImage>[];
      json['listImage'].forEach((v) {
        listImage!.add(ListImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    if (latestMessage != null) {
      data['latestMessage'] = latestMessage!.toJson();
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (infoMore != null) {
      data['infoMore'] = infoMore!.toJson();
    }
    if (listImage != null) {
      data['listImage'] = listImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestMessage {
  int? id;
  int? idUser;
  int? receiver;
  String? content;
  int? newState;

  LatestMessage(
      {this.id, this.idUser, this.receiver, this.content, this.newState});

  LatestMessage.fromJson(Map<String, dynamic> json) {
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
  String? deadline;

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
        this.premiumState,
        this.deadline});

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
    deadline = json['deadline'];
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
    data['deadline'] = deadline;
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
