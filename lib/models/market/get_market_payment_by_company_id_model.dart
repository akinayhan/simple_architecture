class GetMarketPaymentByCompanyIdModel {
  String paymentMethodName;
  String employeeFullName;
  int id;
  int companyId;
  String employeeId;
  int paymentMethodId;
  double price;
  double discount;
  double amount;
  DateTime created;
  String? description;

  GetMarketPaymentByCompanyIdModel({
    required this.paymentMethodName,
    required this.employeeFullName,
    required this.id,
    required this.companyId,
    required this.employeeId,
    required this.paymentMethodId,
    required this.price,
    required this.discount,
    required this.amount,
    required this.created,
    this.description,
  });

  factory GetMarketPaymentByCompanyIdModel.fromJson(Map<String, dynamic> json) {
    return GetMarketPaymentByCompanyIdModel(
      paymentMethodName: json['paymentMethodName'] as String? ?? '',
      employeeFullName: json['employeeFullName'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      employeeId: json['employeeId'] as String? ?? '',
      paymentMethodId: json['paymentMethodId'] as int? ?? 0,
      price: json['price'] as double? ?? 0,
      discount: json['discount'] as double? ?? 0,
      amount: json['amount'] as double? ?? 0,
      created: DateTime.parse(json['created'] as String? ?? DateTime.now().toIso8601String()),
      description: json['description'] as String? ?? '',
    );
  }
}
