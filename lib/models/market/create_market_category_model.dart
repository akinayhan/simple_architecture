class CreateMarketCategoryModel {
  int companyId;
  String categoryName;

  CreateMarketCategoryModel({
    required this.companyId,
    required this.categoryName,
  });

  factory CreateMarketCategoryModel.fromJson(Map<String, Object> json) {
    return CreateMarketCategoryModel(
      companyId: json['companyId'] as int? ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    return {
      'companyId': companyId,
      'categoryName': categoryName,
    };
  }
}