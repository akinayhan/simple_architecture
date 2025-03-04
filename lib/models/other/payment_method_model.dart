class PaymentMethodModel {
  int? id;
  String name;
  bool status;

  PaymentMethodModel({
    this.id,
    required this.name,
    required this.status
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }
}