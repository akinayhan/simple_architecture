class PaymentDetail {
  int productId;
  int piece;

  PaymentDetail({
    required this.productId,
    required this.piece,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'piece': piece,
    };
  }
}

class CreateMarketPaymentModel {
  int companyId;
  String employeeId;
  int paymentMethodId;
  double price;
  double discount;
  double amount;
  String? description;
  List<PaymentDetail> paymentDetails;

  CreateMarketPaymentModel({
    required this.companyId,
    required this.employeeId,
    required this.paymentMethodId,
    required this.price,
    required this.discount,
    required this.amount,
    required this.paymentDetails,
    this.description
  });

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'employeeId': employeeId,
      'paymentMethodId': paymentMethodId,
      'price': price,
      'discount': discount,
      'amount': amount,
      'paymentDetails': paymentDetails.map((e) => e.toJson()).toList(),
      'description' : description
    };
  }
}
