class ModelRequestAuth {
  String? email;
  String? password;
  ModelRequestAuth({this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}