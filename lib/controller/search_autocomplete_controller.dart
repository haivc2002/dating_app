import 'dart:async';

import 'package:dating/bloc/bloc_search_autocomplete/autocomplete_bloc.dart';
import 'package:dating/model/location_model/search_autocomplete_model.dart';
import 'package:dating/service/location/api_search_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAutocompleteController {
  ApiSearchAutocomplete searchAutocomplete = ApiSearchAutocomplete();
  BuildContext context;
  SearchAutocompleteController(this.context);
  Timer? _debounce;

  void getData(String location) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (location == '') {
        return;
      } else {
        onLoad();
        try {
          final SearchAutocompleteModel response = await searchAutocomplete.search(location);
          if (response.type == 'FeatureCollection') {
            final List<Features> listLocation = response.features ?? [];
            onSuccess(listLocation);
          } else {
            onError('Could not find the address');
          }
        } catch (e) {
          onError('Failed to load data: $e');
        }
      }
    });
  }

  void onLoad() {
    context.read<AutocompleteBloc>().add(LoadAutocompleteEvent());
  }

  void onSuccess(List<Features> response) {
    context.read<AutocompleteBloc>().add(SuccessAutocompleteEvent(response));
  }

  void onError(String message) {
    context.read<AutocompleteBloc>().add(ErrorAutocompleteEvent(message));
  }
}