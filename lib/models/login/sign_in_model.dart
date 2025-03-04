class SignInModel {
  String userName;
  String password;

  SignInModel({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'password': password,
    };
  }

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      userName: json['username'],
      password: json['password'],
    );
  }
}
