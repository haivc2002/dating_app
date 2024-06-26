
part of 'store_edit_more_bloc.dart';

class StoreEditMoreEvent {
  String? wine;
  String? smoking;
  String? zodiac;
  int? heightPerson;
  String? homeTown;
  String? character;

  String? textEditingState;

  StoreEditMoreEvent({
    this.wine,
    this.smoking,
    this.zodiac,
    this.heightPerson,
    this.homeTown,
    this.character,
    this.textEditingState
  });
}