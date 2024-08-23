part of 'edit_bloc.dart';

class EditEvent {
  List<File>? imageUpload;
  int? indexPurpose;
  String? purposeValue;
  int? indexLevel;
  ModelInfoUser? modelInfoUser;
  bool? isLoading;

  EditEvent({
    this.imageUpload,
    this.indexPurpose,
    this.purposeValue,
    this.indexLevel,
    this.modelInfoUser,
    this.isLoading,
  });
}
