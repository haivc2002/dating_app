import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../model/location_model/location_current_model.dart';
import '../../tool_widget_custom/popup_custom.dart';

class ApiLocationCurrent {
  static String apiLocationCurrent = 'https://api.geoapify.com/v1/geocode/reverse';

  late Dio dio;
  ApiLocationCurrent() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<LocationCurrentModel> locationCurrent(double lat, double lot) async {
    final response = await dio.get('$apiLocationCurrent?lat=$lat&lon=$lot&format=json&apiKey=b8568cb9afc64fad861a69edbddb2658');
    if(response.statusCode == 200) {
      return LocationCurrentModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          if(context.mounted) {
            PopupCustom.showPopup(context, textContent: "Permission denied, go to settings?", function: () async {
              await openAppSettings();
            });
          }
          return;
        }
      }
    } catch (e) {
      print('Error while getting current location: $e');
    }
  }
}