class GetMarketPaymentDetailByCompanyIdRequestModel {
  final int companyId;
  final int marketPaymentId;

  GetMarketPaymentDetailByCompanyIdRequestModel({
    required this.companyId,
    required this.marketPaymentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
      'MarketPaymentId': marketPaymentId,
    };
  }
}