
//**This is the body of the http post request to register a NEW user */
class LoginRequestData {
  final String email;
  final String password;

  LoginRequestData({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

