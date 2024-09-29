import 'package:dating/model/model_create_payment.dart';
import 'package:dating/service/exception.dart';
import 'package:dating/service/url/api.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ServicePayment {
  String urlCreate = Api.createPayment;

  late Dio dio;
  ServicePayment() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<Result<ModelCreatePayment, Exception>> create() async {
    final response = await dio.post(urlCreate);
    if(response.statusCode == 200) {
      final modelCreatePayment = ModelCreatePayment.fromJson(response.data);
      return Success(modelCreatePayment);
    } else {
      return Failure(Exception('Fail to request ${response.statusCode}'));
    }
  }
}