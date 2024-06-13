

part of 'upload_image_bloc.dart';

class UploadImageEvent {
  List<File>? imageUpload;
  bool? isLoad;

  UploadImageEvent({this.imageUpload, this.isLoad});
}