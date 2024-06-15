import 'package:dating/model/location_model/search_autocomplete_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiSearchAutocomplete {
  String apiSearchAutocomplete = 'https://api.geoapify.com/v1/geocode/autocomplete';
  
  late Dio dio;
  ApiSearchAutocomplete() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<SearchAutocompleteModel> search(String location) async {
    final response = await dio.get('$apiSearchAutocomplete?text=$location&apiKey=b8568cb9afc64fad861a69edbddb2658&limit=5');
    if(response.statusCode == 200) {
      return SearchAutocompleteModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}