class CreateMarketProductModel {
  int companyId;
  String productName;
  int marketCategoryId;
  double productPrice;

  CreateMarketProductModel({
    required this.companyId,
    required this.productName,
    required this.marketCategoryId,
    required this.productPrice
  });

  factory CreateMarketProductModel.fromJson(Map<String, dynamic> json) {
    return CreateMarketProductModel(
      companyId: json['companyId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      marketCategoryId: json['marketCategoryId'] as int? ?? 0,
      productPrice: json['productPrice'] as double? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'marketCategoryId': marketCategoryId,
      'productName': productName,
      'productPrice': productPrice,
    };
  }
}