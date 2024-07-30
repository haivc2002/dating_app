
part of 'autocomplete_bloc.dart';

class AutocompleteState {}

class LoadAutocompleteState extends AutocompleteState {}

class SuccessAutocompleteState extends AutocompleteState {
  List<Features> response;

  SuccessAutocompleteState({required this.response});
}

class ErrorAutocompleteState extends AutocompleteState {
  String message;

  ErrorAutocompleteState({required this.message});
}

