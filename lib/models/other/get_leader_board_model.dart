class GetLeaderBoardModel {
  int companyId;
  String companyName;
  double totalRevenue;

  GetLeaderBoardModel({
    required this.companyId,
    required this.companyName,
    required this.totalRevenue,
  });

  factory GetLeaderBoardModel.fromJson(Map<String, dynamic> json) {
    return GetLeaderBoardModel(
      companyId: json['companyId'] ?? 0,
      companyName: json['companyName'] as String? ?? '',
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
    );
  }
}