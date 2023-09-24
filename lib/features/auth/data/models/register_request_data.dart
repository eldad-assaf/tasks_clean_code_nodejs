
//**This is the body of the http post request to register a NEW user */
class RegisterRequestData {
  final String name;
  final String email;
  final String password;
  RegisterRequestData({
    required this.name,
    required this.email,
    required this.password,
  });
}
