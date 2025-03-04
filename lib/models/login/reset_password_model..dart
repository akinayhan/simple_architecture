class ResetPasswordModel {
  String userId;
  String numCode;
  String token;
  String password;
  String confirmPassword;

  ResetPasswordModel({
    required this.userId,
    required this.numCode,
    required this.token,
    required this.password,
    required this.confirmPassword,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      userId: json['userId'] ?? '',
      numCode: json['numCode'] ?? '',
      token: json['token'] ?? '',
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'numCode': numCode,
      'token': token,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}