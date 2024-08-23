import 'package:dating/model/model_outside_view_message.dart';
import 'package:dating/model/model_request_send.dart';
import 'package:dating/service/exception.dart';
import 'package:dating/service/url/api.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/model_send_message_success.dart';

class ServiceMessage {
  String outsideViewMessage = Api.outsideViewMessage;
  String sendMessage = Api.sendMessage;
  String apiCheckMessage = Api.checkMessage;

  late Dio dio;
  ServiceMessage() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<Result<ModelOutsideViewMessage, Exception>> getOutsideView(int idUser) async {
    try {
      final response = await dio.get('$outsideViewMessage?idUser=$idUser');
      if(response.statusCode == 200) {
        return Success(ModelOutsideViewMessage.fromJson(response.data));
      } else {
        return Failure(Exception('Fail to load data: ${response.statusCode}'));
      }
    } catch(e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<ModelSendMessageSuccess, Exception>> send(ModelRequestSend request) async {
    try {
      final response = await dio.post(sendMessage, data: request.toJson());
      if(response.statusCode == 200) {
        return Success(ModelSendMessageSuccess.fromJson(response.data));
      } else {
        return Failure(Exception('Send Failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  Future<Result<void, Exception>> checkMessage(int idUser, int id) async {
    try {
      final request = await dio.put(apiCheckMessage, data: {"idUser": idUser, "id": id});
      if(request.statusCode == 200) {
        return const Success<void, Exception>(null);
      } else {
        return Failure(Exception("Failed to load data: ${request.statusCode}"));
      }
    } catch (e) {
      return Failure(Exception("Error: ${e.toString()}"));
    }
  }
}