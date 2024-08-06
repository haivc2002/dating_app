import 'package:dating/common/remove_province.dart';

import '../bloc/bloc_home/home_bloc.dart';

String cityCover(SuccessApiHomeState state) {
  if(state.location?[0].state != null) {
    return RemoveProvince.cancel('${state.location?[0].state}');
  } else if(state.location?[0].city != null) {
    return '${state.location?[0].city}';
  } else {
    return 'Unknown';
  }
}

String cityAutoComplete(String input) {
  final regex = RegExp(r',\s*([^,]+?)\s*(province|city)?\s*,', caseSensitive: false);
  final match = regex.firstMatch(input);
  if (match != null) {
    return match.group(1) ?? '';
  } else {
    return '';
  }
}