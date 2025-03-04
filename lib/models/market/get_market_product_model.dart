class GetMarketProductModel {
  int id;
  int companyId;
  String productName;
  int marketCategoryId;
  double productPrice;
  bool status;
  bool deleted;

  GetMarketProductModel({
    required this.id,
    required this.companyId,
    required this.productName,
    required this.marketCategoryId,
    required this.productPrice,
    required this.status,
    required this.deleted,
  });

  factory GetMarketProductModel.fromJson(Map<String, dynamic> json) {
    return GetMarketProductModel(
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      marketCategoryId: json['marketCategoryId'] as int? ?? 0,
      productPrice: json['productPrice'] as double? ?? 0,
      status: json['status'] as bool? ?? true,
      deleted: json['deleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'productName': productName,
      'marketCategoryId': marketCategoryId,
      'productPrice': productPrice,
      'status': status,
      'deleted': deleted,
    };
  }
}
