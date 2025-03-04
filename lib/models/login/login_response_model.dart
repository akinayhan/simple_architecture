class LoginResponseModel {
  final String token;
  final String expireDate;

  LoginResponseModel({required this.token, required this.expireDate});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      expireDate: json['expireDate'],
    );
  }
}
