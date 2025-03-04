class CreateAnnouncementModel {
  String title;
  String? description;
  int visibilityRole;
  bool status;
  bool deleted;
  DateTime startDate;
  DateTime endDate;

  CreateAnnouncementModel({
    required this.title,
    this.description,
    required this.visibilityRole,
    required this.status,
    required this.deleted,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'visibilityRole': visibilityRole,
      'status': status,
      'deleted': deleted,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
