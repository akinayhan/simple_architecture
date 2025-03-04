class SignUpModel {
  String fullName;
  String userName;
  String email;
  String password;
  String confirmPassword;
  String phoneNumber;
  int cityId;
  int districtId;
  String roleName;
  String addressDetail;

  SignUpModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.cityId,
    required this.districtId,
    required this.roleName,
    required this.addressDetail,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      cityId: json['cityId'] ?? 0,
      districtId: json['districtId'] ?? 0,
      roleName: json['roleName'] ?? '',
      addressDetail: json['addressDetail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phoneNumber': phoneNumber,
      'cityId': cityId,
      'districtId': districtId,
      'roleName': roleName,
      'addressDetail': addressDetail,
    };
  }
}