class Api {
  // TODO: POST
  static String login = 'http://192.168.1.152:3000/auth/login';
  static String register = 'http://192.168.1.152:3000/auth/register';
  static String registerInfo = 'http://192.168.1.152:3000/auth/registerInfo';
  static String addImage = 'http://192.168.1.152:3000/auth/addImage';
  static String match = 'http://192.168.1.152:3000/match/add';
  static String sendMessage = 'http://192.168.1.152:3000/message/send';

  // TODO: GET
  static String getNomination = 'http://192.168.1.152:3000/data/listNomination';
  static String getInfo = 'http://192.168.1.152:3000/auth/getInfo';
  static String getListPairing = 'http://192.168.1.152:3000/match/listPairing';
  static String getListUnmatchedUsers = 'http://192.168.1.152:3000/match/listUnmatchedUsers';
  static String outsideViewMessage = 'http://192.168.1.152:3000/message/outsideViewMessage';

  // TODO: PUT
  static String updateLocation = 'http://192.168.1.152:3000/update/updateLocation';
  static String checkNewState = 'http://192.168.1.152:3000/match/checkNewState';
  static String checkMessage = 'http://192.168.1.152:3000/message/isCheckNewMessage';
  static String updateInformation = 'http://192.168.1.152:3000/update/updateUser';
  static String updateImage = 'http://192.168.1.152:3000/update/updateImage';

  // TODO: DELETE
  static String deleteImage = 'http://192.168.1.152:3000/update/deleteImage';

  // TODO: SOCKET
  static String notification = 'ws://192.168.1.152:3000';
  
}