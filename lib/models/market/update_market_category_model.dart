class UpdateMarketCategoryModel {
  int id;
  int companyId;
  String categoryName;
  bool status;
  bool deleted;

  UpdateMarketCategoryModel({
    required this.id,
    required this.companyId,
    required this.categoryName,
    required this.status,
    required this.deleted,
  });

  factory UpdateMarketCategoryModel.fromJson(Map<String, dynamic> json) {
    return UpdateMarketCategoryModel(
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
      status: json['status'] as bool? ?? true,
      deleted: json['deleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'categoryName': categoryName,
      'status': status,
      'deleted': deleted,
    };
  }
}
