
part of 'autocomplete_bloc.dart';

class AutocompleteEvent {}

class LoadAutocompleteEvent extends AutocompleteEvent {}

class SuccessAutocompleteEvent extends AutocompleteEvent {
  List<Features> response;

  SuccessAutocompleteEvent(this.response);
}

class ErrorAutocompleteEvent extends AutocompleteEvent {
  String message;

  ErrorAutocompleteEvent(this.message);
}