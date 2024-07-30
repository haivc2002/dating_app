part of 'register_bloc.dart';

class RegisterEvent {
  double? appBarHeightFactor, indexItemGender;
  int? remainingTime;
  RiveFile? fileRive;
  double? blurValue;
  DateTime? birthdayValue;
  String? desiredState, genderValue;
  double? lat, lon;

  RegisterEvent({
    this.appBarHeightFactor,
    this.indexItemGender,
    this.remainingTime,
    this.birthdayValue,
    this.fileRive,
    this.blurValue,
    this.desiredState,
    this.genderValue,
    this.lon,
    this.lat,
  });
}
