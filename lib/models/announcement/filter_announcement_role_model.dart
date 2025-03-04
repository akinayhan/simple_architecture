class FilterAnnouncementRoleModel {
  final int type;
  late String name;

  FilterAnnouncementRoleModel({required this.type}) {
    if(type == 1){
      name = "Tüm Kullanıcılar";
    }else if(type == 2){
      name = "Firmalar";
    }else if(type == 3){
      name = "Müşteriler";
    } else{
      name = "Geçersiz";
    }
  }
}

List<FilterAnnouncementRoleModel> getAnnouncementRoleList() {
  return [
    FilterAnnouncementRoleModel(type: 1),
    FilterAnnouncementRoleModel(type: 2),
    FilterAnnouncementRoleModel(type: 3),
  ];
}