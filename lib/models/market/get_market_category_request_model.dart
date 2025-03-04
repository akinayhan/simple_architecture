class GetMarketCategoryRequestModel {
  final int companyId;
  final bool status;
  final bool deleted;

  GetMarketCategoryRequestModel({
    required this.companyId,
    required this.status,
    required this.deleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
      'Status': status,
      'Deleted': deleted,
    };
  }
}