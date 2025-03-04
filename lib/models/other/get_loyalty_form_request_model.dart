class GetLoyaltyFormRequestModel {
  final int companyId;

  GetLoyaltyFormRequestModel({
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
    };
  }
}