class GetPaymentMethodsRequestModel {
  final bool status;

  GetPaymentMethodsRequestModel({
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
    };
  }
}