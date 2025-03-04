class CompanyPaymentTimeModel {
  final int duration;
  final String name;

  CompanyPaymentTimeModel({required this.duration, required this.name});

  static List<CompanyPaymentTimeModel> getCompanyUserRoleList() {
    return [
      CompanyPaymentTimeModel(duration: 0, name: "Yenileme Yok (0 Gün)"),
      CompanyPaymentTimeModel(duration: 7, name: "Haftalık (7 Gün)"),
      CompanyPaymentTimeModel(duration: 30, name: "Aylık (30 Gün)"),
      CompanyPaymentTimeModel(duration: 90, name: "Üç Aylık (90 Gün)"),
      CompanyPaymentTimeModel(duration: 365, name: "Yıllık (365 Gün)"),
    ];
  }
}