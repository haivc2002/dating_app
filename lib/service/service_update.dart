import 'dart:convert';

import 'package:dating/model/model_is_check_new_state.dart';
import 'package:dating/model/model_res_update_location.dart';
import 'package:dating/model/model_update_location.dart';
import 'package:dating/service/url/api.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/model_info_user.dart';
import 'exception.dart';

class ServiceUpdate {
  String apiUpdateLocation = Api.updateLocation;
  String apiCheckNewState = Api.checkNewState;
  String apiUpdateInfo = Api.updateInformation;
  String apiUpdateImage = Api.updateImage;
  String apiDeleteImage = Api.deleteImage;

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

  Future<Result<void, Exception>> checkNewState(ModelIsCheckNewState req) async {
    try {
      final request = await dio.put(apiCheckNewState, data: req.toJson());
      if (request.statusCode == 200) {
        return const Success<void, Exception>(null);
      } else {
        return Failure(Exception('Failed with status code: ${request.statusCode}'));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }

  }

  Future<Result<void, Exception>> updateInfo(ModelInfoUser req) async {
    try {
      final response = await Dio().put(
        apiUpdateInfo,
        data: req.toJson(),
      );
      if (response.statusCode == 200) {
        return const Success<void, Exception>(null);
      } else {
        return Failure(Exception("status: ${response.statusCode}"));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<void, Exception>> updateImage(int? id, String image) async {
    FormData formData = FormData.fromMap({
      'id': id,
      'image': await MultipartFile.fromFile(image, filename: 'upload.jpg'),
    });
    try {
      final response = await dio.put(
        apiUpdateImage,
        data: formData,
        options: Options(
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 200) {
        return const Success<void, Exception>(null);
      } else {
        return Failure(Exception("Failed to load API ${response.statusCode}"));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<void, Exception>> deleteImage(int id) async {
    final request = await dio.delete('$apiDeleteImage/$id');
    if(request.statusCode == 200) {
      return const Success<void, Exception>(null);
    } else {
      return Failure(Exception('Delete failed ${request.statusCode}'));
    }
  }

}