import 'package:dating/model/model_req_match.dart';
import 'package:dating/model/model_response_list_pairing.dart';
import 'package:dating/model/model_response_match.dart';
import 'package:dating/model/model_unmatched_users.dart';
import 'package:dating/service/url/api.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ServiceMatch {
  String url = Api.match;
  String urlListPairing = Api.getListPairing;
  String urlListUnmatchedUsers = Api.getListUnmatchedUsers;

  late Dio dio;
  ServiceMatch() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<ModelResponseMatch> match(ModelReqMatch requestMatch) async {
    final request = await dio.post(url, data: requestMatch.toJson());
    if(request.statusCode == 200) {
      return ModelResponseMatch.fromJson(request.data);
    } else {
      throw Exception('Failed add match');
    }
  }

  Future<ModelResponseListPairing> listPairing(int idUser) async {
    final response = await dio.get('$urlListPairing?idUser=$idUser');
    if(response.statusCode == 200) {
      return ModelResponseListPairing.fromJson(response.data);
    } else {
      throw Exception('Failed to load listPairing');
    }
  }

  Future<ModelUnmatchedUsers> listUnmatchedUsers(int idUser) async {
    final response = await dio.get('$urlListUnmatchedUsers?idUser=$idUser');
    if(response.statusCode == 200) {
      return ModelUnmatchedUsers.fromJson(response.data);
    } else {
      throw Exception('Fail to load data');
    }
  }
}