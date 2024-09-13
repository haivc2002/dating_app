import 'package:dating/theme/theme_config.dart';

class Api {
  // TODO: POST
  static String login = 'http${ThemeConfig.baseUrlIp}auth/login';
  static String register = 'http${ThemeConfig.baseUrlIp}auth/register';
  static String registerInfo = 'http${ThemeConfig.baseUrlIp}auth/registerInfo';
  static String addImage = 'http${ThemeConfig.baseUrlIp}auth/addImage';
  static String match = 'http${ThemeConfig.baseUrlIp}match/add';
  static String sendMessage = 'http${ThemeConfig.baseUrlIp}message/send';
  static String createPayment = 'http${ThemeConfig.baseUrlIp}payment/create_payment_url';

  // TODO: GET
  static String getNomination = 'http${ThemeConfig.baseUrlIp}data/listNomination';
  static String getInfo = 'http${ThemeConfig.baseUrlIp}auth/getInfo';
  static String getListPairing = 'http${ThemeConfig.baseUrlIp}match/listPairing';
  static String getListUnmatchedUsers = 'http${ThemeConfig.baseUrlIp}match/listUnmatchedUsers';
  static String outsideViewMessage = 'http${ThemeConfig.baseUrlIp}message/outsideViewMessage';

  // TODO: PUT
  static String updateLocation = 'http${ThemeConfig.baseUrlIp}update/updateLocation';
  static String checkNewState = 'http${ThemeConfig.baseUrlIp}match/checkNewState';
  static String checkMessage = 'http${ThemeConfig.baseUrlIp}message/isCheckNewMessage';
  static String updateInformation = 'http${ThemeConfig.baseUrlIp}update/updateUser';
  static String updateImage = 'http${ThemeConfig.baseUrlIp}update/updateImage';

  // TODO: DELETE
  static String deleteImage = 'http${ThemeConfig.baseUrlIp}update/deleteImage';

  // TODO: SOCKET
  static String notification = 'ws${ThemeConfig.baseUrlIp}';
  
}