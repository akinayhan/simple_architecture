class CompanyUserRoleModel {
  final int type;
  late String name;

  CompanyUserRoleModel({required this.type}) {
    if(type == -1){
      name = "Yönetici";
    }else if(type == -2){
      name = "Müşteri";
    }else{
      name = "Geçersiz Rol";
    }
  }
}

List<CompanyUserRoleModel> getCompanyUserRoleList() {
  return [
    CompanyUserRoleModel(type: -1),
    CompanyUserRoleModel(type: -2),
  ];
}