import 'dart:io';

class ModelRequestImage {
  int? idUser;
  File? image;

  ModelRequestImage({this.idUser, this.image});

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'image': image,
    };
  }
}