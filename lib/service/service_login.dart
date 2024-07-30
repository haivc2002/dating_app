import 'package:dating/model/model_request_auth.dart';
import 'package:dating/service/url/api.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/model_info_user.dart';

class ServiceLogin {
  String url = Api.login;

  late Dio dio;
  ServiceLogin() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<ModelInfoUser> login(ModelRequestAuth req) async {
    print(req.toJson());
    final request = await dio.post(url,
      data: req.toJson()
    );
    if(request.statusCode == 200) {
      return ModelInfoUser.fromJson(request.data);
    } else {
      throw Exception('Failed to request Data');
    }
  }
}