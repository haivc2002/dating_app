import 'dart:convert';

import 'package:dating/model/model_res_update_location.dart';
import 'package:dating/model/model_update_location.dart';
import 'package:dating/service/url/api.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ServiceUpdate {
  String apiUpdateLocation = Api.updateLocation;

  late Dio dio;
  ServiceUpdate() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<ModelResUpdateLocation> updateLocation(ModelUpdateLocation requestLocation) async {
    final request = await dio.put(apiUpdateLocation,
      data: jsonEncode(requestLocation.toJson())
    );
    if(request.statusCode == 200) {
      return ModelResUpdateLocation.fromJson(request.data);
    } else {
      throw Exception('Failed to setup location!');
    }
  }

}