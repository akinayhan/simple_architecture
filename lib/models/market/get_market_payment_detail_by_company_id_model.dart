class GetMarketPaymentDetailByCompanyIdModel {
  String productName;
  int id;
  int companyId;
  int marketPaymentId;
  int productId;
  int piece;
  double unitPrice;
  DateTime created;

  GetMarketPaymentDetailByCompanyIdModel({
    required this.productName,
    required this.id,
    required this.companyId,
    required this.marketPaymentId,
    required this.productId,
    required this.piece,
    required this.unitPrice,
    required this.created,
  });

  factory GetMarketPaymentDetailByCompanyIdModel.fromJson(Map<String, dynamic> json) {
    return GetMarketPaymentDetailByCompanyIdModel(
      productName: json['productName'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      marketPaymentId: json['marketPaymentId'] as int? ?? 0,
      productId: json['productId'] as int? ?? 0,
      piece: json['piece'] as int? ?? 0,
      unitPrice: json['unitPrice'] as double? ?? 0,
      created: DateTime.parse(json['created'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'id': id,
      'companyId': companyId,
      'marketPaymentId': marketPaymentId,
      'productId': productId,
      'piece': piece,
      'unitPrice': unitPrice,
      'created': created.toIso8601String(),
    };
  }
}
