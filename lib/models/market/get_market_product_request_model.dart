class GetMarketProductRequestModel {
  final int companyId;
  final int marketCategoryId;
  final bool status;
  final bool deleted;

  GetMarketProductRequestModel({
    required this.companyId,
    required this.marketCategoryId,
    required this.status,
    required this.deleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
      'MarketCategoryId': marketCategoryId,
      'Status': status,
      'Deleted': deleted,
    };
  }
}