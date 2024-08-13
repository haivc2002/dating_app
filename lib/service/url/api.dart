class Api {
  //[Post]
  static String login = 'http://192.168.164.123:3000/auth/login';
  static String register = 'http://192.168.164.123:3000/auth/register';
  static String registerInfo = 'http://192.168.164.123:3000/auth/registerInfo';
  static String addImage = 'http://192.168.164.123:3000/auth/addImage';
  static String match = 'http://192.168.164.123:3000/match/add';

  //[Get]
  static String getNomination = 'http://192.168.164.123:3000/data/listNomination';
  static String getInfo = 'http://192.168.164.123:3000/auth/getInfo';
  static String getListPairing = 'http://192.168.164.123:3000/match/listPairing';

  //[Put]
  static String updateLocation = 'http://192.168.164.123:3000/update/updateLocation';

  //[Socket]
  static String notification = 'ws://192.168.164.123:3000';


  // //Post
  // static String login = 'http://192.168.1.4:3000/auth/login';
  // static String register = 'http://192.168.1.4:3000/auth/register';
  // static String registerInfo = 'http://192.168.1.4:3000/auth/registerInfo';
  // static String addImage = 'http://192.168.1.4:3000/auth/addImage';
  //
  // //Get
  // static String getNomination = 'http://192.168.1.4:3000/data/listNomination';
  // static String getInfo = 'http://192.168.1.4:3000/auth/getInfo';
  
}