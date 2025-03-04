class ProfileModel {
  String fullName;
  String userName;
  String email;
  String phoneNumber;

  ProfileModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}