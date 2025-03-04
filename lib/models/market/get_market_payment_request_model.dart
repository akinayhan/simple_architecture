class GetMarketPaymentRequestModel {
  final int companyId;
  final String startDate;
  final String endDate;

  GetMarketPaymentRequestModel({
    required this.companyId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
      'StartDate': startDate,
      'EndDate': endDate,
    };
  }
}