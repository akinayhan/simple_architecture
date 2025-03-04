class ForgotPasswordModel {
  int? id;
  String userId;
  String resetPasswordToken;
  DateTime expiredDate;

  ForgotPasswordModel({
    this.id,
    required this.userId,
    required this.resetPasswordToken,
    required this.expiredDate,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      id: json['id'],
      userId: json['userId'] ?? '',
      resetPasswordToken: json['resetPasswordToken'] ?? '',
      expiredDate: DateTime.parse(json['expiredDate']),
    );
  }
}