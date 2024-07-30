part of 'register_bloc.dart';

class RegisterState {
  double? appBarHeightFactor, indexItemGender;
  int? remainingTime;
  RiveFile? fileRive;
  double? blurValue;
  DateTime? birthdayValue;
  String? desiredState, genderValue;
  double? lat, lon;

  RegisterState({
    this.appBarHeightFactor,
    this.indexItemGender,
    this.blurValue,
    this.fileRive,
    this.remainingTime,
    this.birthdayValue,
    this.desiredState,
    this.genderValue,
    this.lat,
    this.lon,
  });
}