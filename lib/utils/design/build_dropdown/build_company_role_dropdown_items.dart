import 'package:flutter/material.dart';
import '../../../models/other/company_user_role_model.dart';

List<DropdownMenuItem<int>> buildCompanyRoleDropdownItems(List<CompanyUserRoleModel> companyUserRoleList) {
  return companyUserRoleList.map((companyUserRoleModel) {
    return DropdownMenuItem<int>(
      value: companyUserRoleModel.type,
      child: Text(companyUserRoleModel.name),
    );
  }).toList();
}