class WarrantPeriodModel {
  final int duration;

  WarrantPeriodModel({required this.duration});

  static List<WarrantPeriodModel> getWarrantyPeriodList() {
    return List.generate(
      61,
          (index) => WarrantPeriodModel(duration: index),
    );
  }
}